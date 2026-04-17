import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlng;

part 'guide_trip_map_state.dart';

class GuideTripMapCubit extends Cubit<GuideTripMapState> {
  GuideTripMapCubit({Dio? dio})
    : _dio = dio ?? Dio(),
      super(GuideTripMapState.initial());

  final Dio _dio;
  final TextEditingController searchController = TextEditingController();

  void onMapTap(latlng.LatLng position) {
    final updatedPoints = List<latlng.LatLng>.from(state.points);
    if (updatedPoints.length == 3) {
      updatedPoints.add(position);
    } else {
      updatedPoints[updatedPoints.length - 1] = position;
    }

    emit(state.copyWith(pickedPoint: position, points: updatedPoints));
  }

  Future<void> searchPlace(String rawQuery) async {
    final query = rawQuery.trim();
    if (query.isEmpty) return;

    emit(state.copyWith(isSearching: true));

    try {
      final response = await _dio.get(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: {'q': query, 'format': 'jsonv2', 'limit': 1},
        options: Options(
          headers: {'User-Agent': 'beyond_the_pramids/1.0 (mobile app)'},
        ),
      );

      final data = response.data;
      if (data is List && data.isNotEmpty) {
        final first = data.first;
        final lat = double.tryParse(first['lat']?.toString() ?? '');
        final lon = double.tryParse(first['lon']?.toString() ?? '');

        if (lat != null && lon != null) {
          final point = latlng.LatLng(lat, lon);
          onMapTap(point);
          queueCameraMove(point, 14.2);
        } else {
          showMessage('Could not read location coordinates.');
        }
      } else {
        showMessage('No places found. Try another keyword.');
      }
    } catch (_) {
      showMessage('Search failed. Check internet and try again.');
    } finally {
      emit(state.copyWith(isSearching: false));
    }
  }

  Future<void> moveToCurrentLocation() async {
    if (state.isLocating) return;

    emit(state.copyWith(isLocating: true));
    try {
      final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        showMessage('Location service is off. Please enable GPS.');
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        showMessage('Location permission denied.');
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final point = latlng.LatLng(position.latitude, position.longitude);
      onMapTap(point);
      queueCameraMove(point, 15.2);
    } catch (_) {
      showMessage('Unable to get current location.');
    } finally {
      emit(state.copyWith(isLocating: false));
    }
  }

  void recenterOnPickedPoint() {
    queueCameraMove(state.pickedPoint, 13.8);
  }

  void queueCameraMove(latlng.LatLng center, double zoom) {
    emit(
      state.copyWith(
        cameraTarget: center,
        cameraZoom: zoom,
        cameraMoveToken: state.cameraMoveToken + 1,
      ),
    );
  }

  void showMessage(String message) {
    emit(
      state.copyWith(message: message, messageToken: state.messageToken + 1),
    );
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
