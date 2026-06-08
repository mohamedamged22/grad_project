import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/network/api_service.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/model/guide_booking_model.dart';
import 'package:dio/dio.dart';

class TouristBookingRepo {
  final ApiService _apiService;

  TouristBookingRepo(this._apiService);

  /// Booking a guide (from guide profile page)
  Future<void> createGuideBookingRequest({
    required int guideId,
    required String title,
    required String startDate,
    required String endDate,
    required String description,
    required num price,
  }) async {
    try {
      final body = <String, dynamic>{
        'tourGuideId': guideId,
        'title': title,
        'startDate': startDate,
        'endDate': endDate,
        'description': description,
        'price': price,
      };

      final response = await _apiService.post('/v1/guide-bookings', body);

      if (response['success'] != true) {
        throw ApiException(
          response['message']?.toString() ?? 'Failed to create booking request',
        );
      }
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  /// Get all bookings for the current tourist
  Future<List<GuideBookingModel>> getTouristBookings() async {
    try {
      final response = await _apiService.get('/v1/guide-bookings/tourist');
      final data = response['data'];
      if (data is List) {
        return data
            .map((item) =>
                GuideBookingModel.fromJson(item as Map<String, dynamic>))
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

  /// Booking a trip (from trip details page)
  Future<void> createTripBookingRequest({
    required int tripId,
    required String category,
    required DateTime date,
    required int touristCount,
    String? notes,
  }) async {
    try {
      final body = <String, dynamic>{
        'category': category,
        'date': date.toUtc().toIso8601String(),
        'touristCount': touristCount,
        if (notes != null && notes.trim().isNotEmpty) 'notes': notes.trim(),
      };
      final response = await _apiService.post('/v1/trips/$tripId/book', body);

      if (response['success'] != true) {
        throw ApiException(
          response['message']?.toString() ?? 'Failed to book trip',
        );
      }
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }
}
