import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/guide_trip_map/presentation/manager/guide_trip_map_cubit.dart';
import 'package:beyond_the_pramids/features/guide_trip_map/presentation/views/widgets/guide_trip_map_control_button.dart';
import 'package:beyond_the_pramids/features/guide_trip_map/presentation/views/widgets/guide_trip_map_pin.dart';
import 'package:beyond_the_pramids/features/guide_trip_map/presentation/views/widgets/guide_trip_map_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;

class GuideTripMapView extends StatelessWidget {
  GuideTripMapView({super.key});

  final MapController _mapController = MapController();

  void _confirmMeetingPoint(BuildContext context, latlng.LatLng pickedPoint) {
    final value =
        '${pickedPoint.latitude.toStringAsFixed(5)}, ${pickedPoint.longitude.toStringAsFixed(5)}';
    Navigator.pop(context, value);
  }

  void _zoomIn() {
    final camera = _mapController.camera;
    final nextZoom = (camera.zoom + 1).clamp(4.0, 18.0);
    _mapController.move(camera.center, nextZoom);
  }

  void _zoomOut() {
    final camera = _mapController.camera;
    final nextZoom = (camera.zoom - 1).clamp(4.0, 18.0);
    _mapController.move(camera.center, nextZoom);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GuideTripMapCubit>();

    return BlocListener<GuideTripMapCubit, GuideTripMapState>(
      listenWhen:
          (previous, current) =>
              previous.cameraMoveToken != current.cameraMoveToken ||
              previous.messageToken != current.messageToken,
      listener: (context, state) {
        if (state.cameraTarget != null && state.cameraZoom != null) {
          _mapController.move(state.cameraTarget!, state.cameraZoom!);
        }

        final message = state.message;
        if (message != null && message.trim().isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Scaffold(
        body: BlocBuilder<GuideTripMapCubit, GuideTripMapState>(
          builder: (context, state) {
            return Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: GuideTripMapState.cairoCenter,
                    initialZoom: 11.6,
                    onTap:
                        (_, point) =>
                            context.read<GuideTripMapCubit>().onMapTap(point),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.beyond_the_pramids',
                      maxNativeZoom: 19,
                    ),
                    MarkerLayer(
                      markers:
                          state.points
                              .map(
                                (point) => Marker(
                                  point: point,
                                  width: 34,
                                  height: 34,
                                  child: GuideTripMapPin(
                                    selected:
                                        point.latitude ==
                                            state.pickedPoint.latitude &&
                                        point.longitude ==
                                            state.pickedPoint.longitude,
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ),
                GuideTripMapSearchBar(
                  controller: cubit.searchController,
                  isSearching: state.isSearching,
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                    context.read<GuideTripMapCubit>().searchPlace(value);
                  },
                  onSearchTap: () {
                    FocusScope.of(context).unfocus();
                    context.read<GuideTripMapCubit>().searchPlace(
                      cubit.searchController.text,
                    );
                  },
                  onBackTap: () => Navigator.pop(context),
                ),
                Positioned(
                  right: 12.w,
                  bottom: 92.h,
                  child: Column(
                    children: [
                      GuideTripMapControlButton(
                        icon: Icons.add,
                        onTap: _zoomIn,
                      ),
                      SizedBox(height: 8.h),
                      GuideTripMapControlButton(
                        icon: Icons.remove,
                        onTap: _zoomOut,
                      ),
                      SizedBox(height: 8.h),
                      GuideTripMapControlButton(
                        icon:
                            state.isLocating
                                ? Icons.hourglass_top_rounded
                                : Icons.my_location_rounded,
                        onTap:
                            () =>
                                context
                                    .read<GuideTripMapCubit>()
                                    .moveToCurrentLocation(),
                      ),
                      SizedBox(height: 8.h),
                      GuideTripMapControlButton(
                        icon: Icons.center_focus_strong_rounded,
                        onTap:
                            () =>
                                context
                                    .read<GuideTripMapCubit>()
                                    .recenterOnPickedPoint(),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 16.w,
                  right: 16.w,
                  bottom: 20.h,
                  child: ElevatedButton(
                    onPressed:
                        () => _confirmMeetingPoint(context, state.pickedPoint),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.secondaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 48.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                    ),
                    child: Text(
                      'Use this meeting point',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
