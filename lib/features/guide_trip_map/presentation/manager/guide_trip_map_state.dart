part of 'guide_trip_map_cubit.dart';

class GuideTripMapState {
  static const latlng.LatLng cairoCenter = latlng.LatLng(30.0444, 31.2357);

  final latlng.LatLng pickedPoint;
  final List<latlng.LatLng> points;
  final bool isSearching;
  final bool isLocating;
  final latlng.LatLng? cameraTarget;
  final double? cameraZoom;
  final int cameraMoveToken;
  final String? message;
  final int messageToken;

  const GuideTripMapState({
    required this.pickedPoint,
    required this.points,
    required this.isSearching,
    required this.isLocating,
    required this.cameraTarget,
    required this.cameraZoom,
    required this.cameraMoveToken,
    required this.message,
    required this.messageToken,
  });

  factory GuideTripMapState.initial() {
    return const GuideTripMapState(
      pickedPoint: cairoCenter,
      points: [
        latlng.LatLng(30.0459, 31.2243),
        latlng.LatLng(29.9792, 31.1342),
        latlng.LatLng(30.0478, 31.2625),
      ],
      isSearching: false,
      isLocating: false,
      cameraTarget: null,
      cameraZoom: null,
      cameraMoveToken: 0,
      message: null,
      messageToken: 0,
    );
  }

  GuideTripMapState copyWith({
    latlng.LatLng? pickedPoint,
    List<latlng.LatLng>? points,
    bool? isSearching,
    bool? isLocating,
    latlng.LatLng? cameraTarget,
    double? cameraZoom,
    int? cameraMoveToken,
    String? message,
    int? messageToken,
  }) {
    return GuideTripMapState(
      pickedPoint: pickedPoint ?? this.pickedPoint,
      points: points ?? this.points,
      isSearching: isSearching ?? this.isSearching,
      isLocating: isLocating ?? this.isLocating,
      cameraTarget: cameraTarget ?? this.cameraTarget,
      cameraZoom: cameraZoom ?? this.cameraZoom,
      cameraMoveToken: cameraMoveToken ?? this.cameraMoveToken,
      message: message ?? this.message,
      messageToken: messageToken ?? this.messageToken,
    );
  }
}
