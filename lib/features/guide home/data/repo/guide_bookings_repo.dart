import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/network/api_service.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/model/guide_booking_model.dart';
import 'package:dio/dio.dart';

class GuideBookingsRepo {
  final ApiService _apiService;

  GuideBookingsRepo(this._apiService);

  Future<List<GuideBookingModel>> getBookings({
    String status = 'PENDING',
  }) async {
    try {
      final response = await _apiService.get(
        '/v1/guide-bookings/guide/$status',
      );

      final data = response['data'];
      if (data is List) {
        return data
            .map(
              (item) =>
                  GuideBookingModel.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      }
      return [];
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<bool> acceptBooking({required int bookingId}) async {
    try {
      await _apiService.patch('/v1/guide-bookings/$bookingId/accept', {});
      return true;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<bool> rejectBooking({required int bookingId}) async {
    try {
      await _apiService.patch('/v1/guide-bookings/$bookingId/reject', {});
      return true;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }
}
