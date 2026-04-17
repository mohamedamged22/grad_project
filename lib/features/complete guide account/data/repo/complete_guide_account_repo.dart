import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/network/api_service.dart';
import 'package:beyond_the_pramids/core/utils/pref_helper.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/data/models/basicInfo_model.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CompleteGuideAccountRepo {
  final ApiService _apiService;

  CompleteGuideAccountRepo(this._apiService);

  /// ----------------------------
  /// GET BASIC INFO (with token from storage)
  /// ----------------------------
  Future<BasicInfoModel?> getBasicInfo() async {
    try {
      final token = await PrefHelper.getToken();

      if (token == null || token.isEmpty || token == 'guest') {
        throw ApiException('auth_no_auth_token'.tr());
      }

      debugPrint('🔑 Token: ${token.substring(0, 20)}...');

      final response = await _apiService.get('/tourguide/profile/basic-info');

      debugPrint('Get Basic Info Response: $response');
      debugPrint('📋 Response data keys: ${response['data']?.keys}');
      debugPrint('📋 Response data: ${response['data']}');

      if (response['success'] == true && response['data'] != null) {
        return BasicInfoModel.fromJson(response['data']);
      }

      return null;
    } on DioException catch (e) {
      debugPrint('❌ Failed to fetch basic info: ${e.response?.data}');

      // If unauthorized, clear token
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        await PrefHelper.clearToken();
      }

      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  /// ----------------------------
  /// POST/UPDATE BASIC INFO (with token from storage)
  /// ----------------------------
  Future<Map<String, dynamic>> updateBasicInfo({
    required String name,
    required String email,
    required String phone,
    required String city,
  }) async {
    try {
      // ⭐ جيب التوكن من الـ storage
      final token = await PrefHelper.getToken();

      if (token == null || token.isEmpty || token == 'guest') {
        throw ApiException('auth_no_auth_token'.tr());
      }

      debugPrint('🔑 Token: ${token.substring(0, 20)}...');
      debugPrint(
        '📤 Sending Basic Info: name=$name, email=$email, phone=$phone, city=$city',
      );

      final response = await _apiService.post('/tourguide/profile/basic-info', {
        "name": name,
        "email": email,
        "phone": phone,
        "city": city,
      });

      debugPrint('✅ Update Basic Info Response: $response');

      // Check success
      if (response['success'] == true) {
        return {
          'success': true,
          'message':
              response['message']?.toString() ??
              'Basic info updated successfully',
          'data': response['data'],
        };
      }

      // Handle error
      final errorMessage =
          response['message']?.toString() ?? 'Failed to update basic info';
      throw ApiException(errorMessage);
    } on DioException catch (e) {
      debugPrint('❌ Update Basic Info DioException: ${e.response?.data}');

      // If unauthorized, clear token
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        await PrefHelper.clearToken();
        throw ApiException('auth_session_expired'.tr());
      }

      final serverMessage = e.response?.data?['message']?.toString();

      if (serverMessage != null && serverMessage.isNotEmpty) {
        if (serverMessage.toLowerCase().contains('email')) {
          throw ApiException('auth_email_in_use'.tr());
        } else if (serverMessage.toLowerCase().contains('name')) {
          throw ApiException('auth_name_required'.tr());
        } else if (serverMessage.toLowerCase().contains('phone')) {
          throw ApiException('auth_invalid_phone'.tr());
        } else if (serverMessage.toLowerCase().contains('city')) {
          throw ApiException('auth_city_required'.tr());
        } else {
          throw ApiException(serverMessage);
        }
      }

      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  /// ----------------------------
  /// POST/UPDATE ProfessionalInfo (with token from storage)
  /// ----------------------------

  Future<Map<String, dynamic>> updateProfessionalInfo({
    required String guideType,
    required String licensedNumber,
    required int yearsOfExperience,
    required List<String> specialization,
  }) async {
    try {
      final response = await _apiService
          .post('/tourguide/profile/professional-info', {
            "guideType": guideType,
            "licensedNumber": licensedNumber,
            "yearsOfExperience": yearsOfExperience,
            "specialization": specialization,
          });

      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  /// ----------------------------
  /// POST/UPDATE languages (with token from storage)
  /// ----------------------------
  Future<Map<String, dynamic>> updateLanguages({
    required List<Map<String, String>> languages,
  }) async {
    try {
      final response = await _apiService.post('/tourguide/profile/languages', {
        "languages": languages,
      });
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  /// ----------------------------
  /// POST/UPDATE languages (with token from storage)
  /// ----------------------------

  Future<Map<String, dynamic>> updatePricing({
    required String tourType,
    required List<String> coveredAreas,
    required int tourDuration,
  }) async {
    try {
      final response = await _apiService
          .post('/tourguide/profile/tour-details', {
            "tourType": tourType,
            "coveredArea": coveredAreas.join(', '),
            "tourDuration": tourDuration,
          });
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Map<String, dynamic>> uploadId({required String filePath}) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });
      final response = await _apiService.post(
        '/tourguide/profile/id',
        formData,
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Map<String, dynamic>> uploadLicense({required String filePath}) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });
      final response = await _apiService.post(
        '/tourguide/profile/license',
        formData,
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Map<String, dynamic>> uploadPhoto({required String filePath}) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });
      final response = await _apiService.post(
        '/tourguide/profile/photo',
        formData,
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
