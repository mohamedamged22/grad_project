import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/network/api_service.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_public_trip.dart';
import 'package:dio/dio.dart';

class TouristPublicTripsRepo {
  final ApiService _apiService;

  TouristPublicTripsRepo(this._apiService);

  Future<List<TouristPublicTrip>> fetchPublicTrips({
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _apiService.get(
        '/v1/trips',
        queryParams: {'page': page, 'size': size},
      );

      if (response['success'] != true) {
        throw ApiException(
          response['message']?.toString() ?? 'Failed to fetch trips',
        );
      }

      final data = response['data'];
      if (data is! Map<String, dynamic>) {
        throw ApiException('Invalid trips response format');
      }

      final content = data['content'];
      if (content is! List) {
        return const [];
      }

      return content
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
}
