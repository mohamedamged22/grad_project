import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/network/api_service.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_landmark_list_item.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_landmark_details.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_landmark_trip.dart';
import 'package:dio/dio.dart';

class TouristLandmarkRepo {
  final ApiService _apiService;

  TouristLandmarkRepo(this._apiService);

  Future<TouristLandmarkDetails> fetchLandmarkDetails({required int id}) async {
    try {
      final response = await _apiService.get('/v1/public/landmarks/$id');

      if (response['success'] != true) {
        throw ApiException(
          response['message']?.toString() ?? 'Failed to fetch landmark details',
        );
      }

      final data = response['data'];
      if (data is! Map<String, dynamic>) {
        throw ApiException('Invalid landmark details response format');
      }

      return TouristLandmarkDetails.fromJson(data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<List<TouristLandmarkListItem>> fetchLandmarks({
    String? type,
    String? city,
    String? name,
    int page = 0,
    int size = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'size': size,
      };
      if (type != null && type.trim().isNotEmpty) {
        queryParams['type'] = type.trim();
      }
      if (city != null && city.trim().isNotEmpty) {
        queryParams['city'] = city.trim();
      }
      if (name != null && name.trim().isNotEmpty) {
        queryParams['name'] = name.trim();
      }

      final response = await _apiService.get(
        '/v1/public/landmarks',
        queryParams: queryParams,
      );

      if (response['success'] != true) {
        throw ApiException(
          response['message']?.toString() ?? 'Failed to fetch landmarks',
        );
      }

      final data = response['data'];
      if (data is! Map<String, dynamic>) {
        throw ApiException('Invalid landmarks response format');
      }

      final content = data['content'];
      if (content is! List) {
        return const [];
      }

      return content
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

  Future<List<TouristLandmarkTrip>> fetchLandmarkTrips({
    required int landmarkId,
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _apiService.get(
        '/v1/public/landmarks/$landmarkId/trips',
        queryParams: {'page': page, 'size': size},
      );

      if (response['success'] != true) {
        throw ApiException(
          response['message']?.toString() ?? 'Failed to fetch landmark trips',
        );
      }

      final data = response['data'];
      if (data is! Map<String, dynamic>) {
        throw ApiException('Invalid landmark trips response format');
      }

      final content = data['content'];
      if (content is! List) {
        return const [];
      }

      return content
          .whereType<Map<String, dynamic>>()
          .map(TouristLandmarkTrip.fromJson)
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }
}
