import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/network/api_service.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/data/models/guide_create_trip_basic_request_model.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/data/models/guide_last_created_trip_model.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/data/models/guide_create_trip_price_request_model.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/data/models/guide_create_trip_time_request_model.dart';
import 'package:dio/dio.dart';

class GuideCreateTripRepo {
  final ApiService _apiService;
  int? _currentTripId;

  GuideCreateTripRepo(this._apiService);

  int? get currentTripId => _currentTripId;

  

  Future<String> createBasicTrip(GuideCreateTripBasicRequestModel model) async {
    try {
      _currentTripId = null;
      final response = await _apiService.post('/v1/trip/create-basic', model.toJson());

      if (response['success'] == true) {
        final tripId = _extractTripId(response['data']);
        if (tripId == null) {
          throw ApiException('Trip created but no trip id returned from backend');
        }
        _currentTripId = tripId;
        return response['message']?.toString() ?? 'Created';
      }

      throw ApiException(response['message']?.toString() ?? 'Failed to create trip');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<String> createTripTime(GuideCreateTripTimeRequestModel model) async {
    try {
      final tripId = _requireTripId();
      final payload = Map<String, dynamic>.from(model.toJson());

      final response = await _apiService.post('/v1/trip/$tripId/trip-time', payload);

      if (response['success'] == true) {
        return response['message']?.toString() ?? 'Added';
      }

      throw ApiException(response['message']?.toString() ?? 'Failed to save trip time');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<String> createTripPrice(GuideCreateTripPriceRequestModel model) async {
    try {
      final tripId = _requireTripId();
      final payload = Map<String, dynamic>.from(model.toJson());

      final response = await _apiService.post('/v1/trip/$tripId/trip-price', payload);

      if (response['success'] == true) {
        return response['message']?.toString() ?? 'Added';
      }

      throw ApiException(response['message']?.toString() ?? 'Failed to save trip price');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<GuideUploadCoverResult> uploadTripCover(String filePath) async {
    final tripId = _requireTripId();
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });

      final response = await _apiService.post(
        '/v1/trip/$tripId/upload-cover',
        formData,
      );

      if (response['success'] == true) {
        return GuideUploadCoverResult(
          message: response['message']?.toString() ?? 'Image uploaded successfully',
          uploadedImagePath: _extractUploadedImagePath(response['data']),
        );
      }

      throw ApiException(response['message']?.toString() ?? 'Failed to upload cover');
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<GuideLastCreatedTripModel> getLastCreatedTrip() async {
    try {
      final response = await _apiService.get(
        '/v1/trip/guideTrips',
        queryParams: {'statusKey': 'NEW'},
      );

      if (response['success'] != true) {
        throw ApiException(
          response['message']?.toString() ?? 'Failed to fetch last created trip',
        );
      }

      final data = response['data'];
      if (data is! List) {
        throw ApiException('Invalid response data for last created trip');
      }

      final tripMaps =
          data.whereType<Map<String, dynamic>>().toList(growable: false);
      if (tripMaps.isEmpty) {
        throw ApiException('No new trips found');
      }

      tripMaps.sort((a, b) {
        final aId = (a['id'] as num?)?.toInt() ?? 0;
        final bId = (b['id'] as num?)?.toInt() ?? 0;
        return bId.compareTo(aId);
      });

      return GuideLastCreatedTripModel.fromJson(tripMaps.first);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  int _requireTripId() {
    final tripId = _currentTripId;
    if (tripId == null || tripId <= 0) {
      throw ApiException('Trip id is missing. Please create basic trip first.');
    }
    return tripId;
  }

  int? _extractTripId(dynamic data) {
    if (data == null) return null;

    if (data is int) return data > 0 ? data : null;
    if (data is num) {
      final parsed = data.toInt();
      return parsed > 0 ? parsed : null;
    }

    if (data is String) {
      final parsed = int.tryParse(data.trim());
      return (parsed != null && parsed > 0) ? parsed : null;
    }

    if (data is Map<String, dynamic>) {
      final candidateKeys = ['id', 'tripId', 'trip_id', 'trip'];
      for (final key in candidateKeys) {
        final candidate = _extractTripId(data[key]);
        if (candidate != null) return candidate;
      }
    }

    return null;
  }

  String? _extractUploadedImagePath(dynamic data) {
    if (data == null) return null;

    if (data is String) {
      final value = data.trim();
      return value.isEmpty ? null : value;
    }

    if (data is Map<String, dynamic>) {
      final candidateKeys = ['imageUrl', 'image', 'url', 'path', 'filePath', 'file'];
      for (final key in candidateKeys) {
        final candidate = _extractUploadedImagePath(data[key]);
        if (candidate != null) return candidate;
      }
    }

    return null;
  }
}

class GuideUploadCoverResult {
  final String message;
  final String? uploadedImagePath;

  const GuideUploadCoverResult({
    required this.message,
    required this.uploadedImagePath,
  });
}
