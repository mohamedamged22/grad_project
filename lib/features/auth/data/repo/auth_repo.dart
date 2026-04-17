import 'package:beyond_the_pramids/core/network/api_error.dart';
import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/network/api_service.dart';
import 'package:beyond_the_pramids/core/utils/pref_helper.dart';
import 'package:beyond_the_pramids/features/auth/data/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AuthRepo {
  final ApiService _apiService;
  AuthRepo(this._apiService);
  bool isGuest = false;

  //login
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> response = await _apiService.post(
        '/auth/login',
        {"email": email, "password": password},
      );

      // ✅ تحقق من success
      if (response['success'] != true) {
        final message =
            response['message']?.toString() ?? 'auth_login_failed'.tr();
        throw ApiError(message: message);
      }

      // ✅ التوكن من data
      final token = response['data']?['token']?.toString();
      if (token == null || token.isEmpty) {
        throw ApiError(message: 'auth_no_token'.tr());
      }

      final user = UserModel(
        token: token,
        name: response['data']?['name']?.toString(),
        email: response['data']?['email']?.toString(),
      );

      // ✅ حفظ التوكن
      await PrefHelper.saveToken(token);
      await PrefHelper.setProfileCompleted(true);

      isGuest = false;
      _currentUser = user;

      return user;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// ----------------------------
  /// SIGNUP
  /// ----------------------------
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await _apiService.post('/auth/signup', {
        "username": name,
        "email": email,
        "password": password,
        "role": role,
      });

      // ✅ Match the same success check as login
      if (response['success'] != true) {
        final errorMessage =
            response['message']?.toString() ?? 'auth_signup_failed'.tr();
        throw ApiException(errorMessage);
      }

      // ✅ Token is inside data, just like login
      final token = response['data']?['token']?.toString();
      if (token == null || token.isEmpty) {
        throw ApiException('auth_no_token'.tr());
      }

      final user = UserModel(
        token: token,
        name: response['data']?['name']?.toString() ?? name,
        email: response['data']?['email']?.toString() ?? email,
      );

      await PrefHelper.saveToken(token);
      await PrefHelper.saveUserRole(role == 'TOURGUIDE' ? 'guide' : 'tourist');
      await PrefHelper.setProfileCompleted(false);
      isGuest = false;
      _currentUser = user;

      return user;
    } on DioException catch (e) {
      final serverMessage = e.response?.data?['message']?.toString();
      if (serverMessage != null) {
        if (serverMessage.toLowerCase().contains('password')) {
          throw ApiException('auth_password_weak'.tr());
        } else if (serverMessage.toLowerCase().contains('email')) {
          throw ApiException('auth_email_registered'.tr());
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
  /// Forget PASSWORD
  /// ----------------------------
  Future<String> forgetPassword({required String email}) async {
    try {
      final response = await _apiService.post(
        '/auth/forgetPassword',
        null,
        queryParameters: {'email': email},
      );

      debugPrint('Forget Password Response: $response');

      final success = response['success'] == true;
      final message = response['message']?.toString();

      if (success) {
        return message ?? 'auth_otp_sent'.tr();
      }

      throw ApiException(message ?? 'auth_failed_send_otp'.tr());
    } on ApiException {
      rethrow;
    } catch (e) {
      debugPrint('Unexpected Error: $e');
      throw ApiException('auth_unexpected_error'.tr());
    }
  }

  /// ----------------------------
  /// check Otp
  /// ----------------------------
  Future<String> checkOtp({required String otp}) async {
    try {
      final response = await _apiService.post('/auth/verify', {"OTP": otp});

      if (response['success'] == true) {
        return response['message']?.toString() ?? 'auth_otp_correct'.tr();
      }

      final errorMessage =
          response['message']?.toString() ?? 'auth_otp_wrong'.tr();
      throw ApiException(errorMessage);
    } on DioException catch (e) {
      final serverMessage = e.response?.data?['message']?.toString();
      if (serverMessage != null && serverMessage.isNotEmpty) {
        throw ApiException(serverMessage);
      }
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  /// ----------------------------
  /// RESET PASSWORD
  /// ----------------------------
  Future<String> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await _apiService.post('/auth/ResetPassword', {
        "email": email,
        "newPassword": newPassword,
      });

      debugPrint('Reset Password Response: $response');

      if (response['success'] == true) {
        return response['message']?.toString() ??
            'auth_password_reset_success'.tr();
      }

      throw ApiException(
        response['message']?.toString() ?? 'auth_reset_failed'.tr(),
      );
    } on DioException catch (e) {
      final serverMessage = e.response?.data?['message']?.toString();
      if (serverMessage != null && serverMessage.isNotEmpty) {
        throw ApiException(serverMessage);
      }
      throw ApiException.fromDioError(e);
    } catch (e) {
      debugPrint('Unexpected Error: $e');
      throw ApiException('auth_unexpected_error'.tr());
    }
  }

  /// ----------------------------
  /// LOGOUT
  /// ----------------------------
  Future<void> logout() async {
    try {
      await _apiService.post('/logout', {});
      await PrefHelper.clearToken();
      await PrefHelper.clearAuthMetadata();
      isGuest = true;
      _currentUser = null;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// ----------------------------
  /// PROFILE
  /// ----------------------------
  Future<UserModel?> getProfileData() async {
    try {
      final token = await PrefHelper.getToken();
      if (token == null || token == 'guest') {
        return null;
      }

      final response = await _apiService.get('/profile');
      final user = UserModel.fromJson(response['data']);
      isGuest = false;
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// ----------------------------
  /// update profile data
  /// ----------------------------
  Future<UserModel> updateProfileData({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
  }) async {
    final formData = FormData.fromMap({
      'name': name,
      'email': email,
      'address': address,
      if (visa != null && visa.isNotEmpty) 'Visa': visa,
      if (imagePath != null && imagePath.isNotEmpty)
        'image': await MultipartFile.fromFile(
          imagePath,
          filename: 'profile.jpg',
        ),
    });
    try {
      final response = await _apiService.post('/update-profile', formData);
      if (response['code'] != null && response['code'] != 200) {
        final errorMessage =
            response['message']?.toString() ?? 'auth_update_failed'.tr();
        if (errorMessage.toLowerCase().contains('email')) {
          throw ApiError(message: 'auth_email_already_used'.tr());
        } else if (errorMessage.toLowerCase().contains('image')) {
          throw ApiError(message: 'auth_invalid_image'.tr());
        } else if (errorMessage.toLowerCase().contains('address')) {
          throw ApiError(message: 'auth_address_required'.tr());
        } else {
          throw ApiError(message: errorMessage);
        }
      }

      final user = UserModel.fromJson(response['data']);
      isGuest = false;
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// ----------------------------
  /// continue as Guest
  /// ----------------------------
  Future<void> continueAsGuest() async {
    isGuest = true;
    _currentUser = null;
    await PrefHelper.saveToken('guest');
    await PrefHelper.clearAuthMetadata();
  }

  /// ----------------------------
  /// AUTO LOGIN
  /// ----------------------------
  Future<UserModel?> autoLogin() async {
    final token = await PrefHelper.getToken();

    if (token == null || token.isEmpty || token == 'guest') {
      isGuest = true;
      _currentUser = null;
      return null;
    }

    try {
      final user = await getProfileData();

      if (user != null) {
        isGuest = false;
        _currentUser = user;
        return user;
      } else {
        isGuest = true;
        _currentUser = null;
        return null;
      }
    } catch (e) {
      await PrefHelper.clearToken();
      await PrefHelper.clearAuthMetadata();
      isGuest = true;
      _currentUser = null;
      return null;
    }
  }

  // Getter for current user
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  // Logged in check
  bool get isLoggedIn => !isGuest && _currentUser != null;
}
