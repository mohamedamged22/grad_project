import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/network/api_service.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/model/guide_trip_summary_model.dart';
import 'package:dio/dio.dart';

class GuideMyTripRepo {
  final ApiService _apiService;

  GuideMyTripRepo(this._apiService);

  Future<List<GuideTripSummaryModel>> fetchTrips({String? statusKey}) async {
    try {
      final response = await _apiService.get(
        '/v1/trip/guideTrips',
        queryParams: statusKey != null ? {'statusKey': statusKey} : null,
      );

      if (response['success'] != true) {
        throw ApiException(
          response['message']?.toString() ?? 'Failed to fetch trips',
        );
      }

      final data = response['data'];
      if (data is! List) {
        throw ApiException('Invalid response data for trips');
      }

      return data
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
