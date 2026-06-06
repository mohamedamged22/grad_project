import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/network/api_service.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/model/guide_trip_summary_model.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tour_guide_profile.dart';
import 'package:dio/dio.dart';

class TourGuideProfilesRepo {
  final ApiService _apiService;
  TourGuideProfilesRepo(this._apiService);

  /// GET /api/v1/tour-guides?city=Cairo  — returns data: [ {...}, {...} ]
  Future<List<TourGuideProfile>> fetchProfiles({String? city}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (city != null && city.isNotEmpty) queryParams['city'] = city;

      final response = await _apiService.get(
        '/v1/tour-guides',
        queryParams: queryParams.isEmpty ? null : queryParams,
      );

      if (response['success'] != true) {
        throw ApiException(
          response['message']?.toString() ?? 'Failed to fetch guides',
        );
      }

      final data = response['data'];
      if (data is! List) return const [];

      return data
          .whereType<Map<String, dynamic>>()
          .map(TourGuideProfile.fromJson)
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  /// GET /api/v1/tour-guides/{guideId}  — returns data: { ... }
  Future<TourGuideProfile> fetchProfileById(int id) async {
    try {
      final response = await _apiService.get('/v1/tour-guides/$id');

      if (response['success'] != true) {
        throw ApiException(
          response['message']?.toString() ?? 'Failed to fetch guide profile',
        );
      }

      final data = response['data'];
      if (data is! Map<String, dynamic>) {
        throw ApiException('Invalid guide profile response format');
      }

      return TourGuideProfile.fromJson(data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  /// GET /v1/trips/guide/{guideId} — unchanged
  Future<List<GuideTripSummaryModel>> fetchGuideTrips({
    required int guideId,
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _apiService.get(
        '/v1/trips/guide/$guideId',
        queryParams: {'page': page, 'size': size},
      );

      if (response['success'] != true) {
        throw ApiException(
          response['message']?.toString() ?? 'Failed to fetch guide trips',
        );
      }

      final data = response['data'];
      if (data is! Map<String, dynamic>) {
        throw ApiException('Invalid guide trips response format');
      }

      final content = data['content'];
      if (content is! List) return const [];

      return content
          .whereType<Map<String, dynamic>>()
          .map(GuideTripSummaryModel.fromJson)
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }
}
