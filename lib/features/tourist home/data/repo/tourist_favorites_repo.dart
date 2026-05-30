import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/network/api_service.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_landmark_list_item.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_public_trip.dart';
import 'package:dio/dio.dart';

class TouristFavoritesRepo {
  final ApiService _apiService;

  TouristFavoritesRepo(this._apiService);

  Future<void> addTripFavorite({required int tripId}) async {
    try {
      final response = await _apiService.post(
        '/favorites/trips/$tripId',
        const {},
      );
      _ensureSuccess(response, 'Failed to save trip');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<List<TouristPublicTrip>> getFavoriteTrips() async {
    try {
      final response = await _apiService.get('/favorites/trips');
      _ensureSuccess(response, 'Failed to load favorite trips');

      if (response is! Map<String, dynamic>) return const [];
      final data = response['data'];
      if (data is! List) return const [];

      return data
          .whereType<Map<String, dynamic>>()
          .map(TouristPublicTrip.fromJson)
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<void> removeTripFavorite({required int tripId}) async {
    try {
      final response = await _apiService.delete('/favorites/trips/$tripId');
      _ensureSuccess(response, 'Failed to remove trip');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<void> addLandmarkFavorite({required int landmarkId}) async {
    try {
      final response = await _apiService.post(
        '/favorites/landmarks/$landmarkId',
        const {},
      );
      _ensureSuccess(response, 'Failed to save landmark');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<List<TouristLandmarkListItem>> getFavoriteLandmarks() async {
    try {
      final response = await _apiService.get('/favorites/landmarks');
      _ensureSuccess(response, 'Failed to load favorite landmarks');

      if (response is! Map<String, dynamic>) return const [];
      final data = response['data'];
      if (data is! List) return const [];

      return data
          .whereType<Map<String, dynamic>>()
          .map(TouristLandmarkListItem.fromJson)
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<void> removeLandmarkFavorite({required int landmarkId}) async {
    try {
      final response = await _apiService.delete(
        '/favorites/landmarks/$landmarkId',
      );
      _ensureSuccess(response, 'Failed to remove landmark');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  void _ensureSuccess(dynamic response, String fallbackMessage) {
    if (response is Map<String, dynamic>) {
      final success = response['success'];
      if (success == false) {
        throw ApiException(
          response['message']?.toString() ?? fallbackMessage,
        );
      }
    }
  }
}
