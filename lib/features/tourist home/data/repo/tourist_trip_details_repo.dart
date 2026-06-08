import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/network/api_service.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_trip_details.dart';
import 'package:dio/dio.dart';

class TouristTripDetailsRepo {
  final ApiService _apiService;

  TouristTripDetailsRepo(this._apiService);

  Future<TouristTripDetails> fetchTripDetails({required int tripId}) async {
    try {
      final response = await _apiService.get('/v1/static-trips/$tripId');

      if (response['success'] != true) {
        throw ApiException(
          response['message']?.toString() ?? 'Failed to fetch trip details',
        );
      }

      final data = response['data'];
      if (data is! Map<String, dynamic>) {
        throw ApiException('Invalid trip details response format');
      }

      return TouristTripDetails.fromJson(data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }
}
