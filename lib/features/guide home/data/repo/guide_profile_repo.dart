import 'dart:convert';

import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/network/api_service.dart';
import 'package:beyond_the_pramids/core/utils/pref_helper.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/model/guide_profile_dashboard_model.dart';
import 'package:dio/dio.dart';

class GuideProfileRepo {
  static const String _dashboardCacheKey = 'guide_dashboard_cache';
  static const String _profileInfoCacheKey = 'guide_profile_info_cache';

  final ApiService _apiService;

  GuideProfileRepo(this._apiService);

  Future<GuideProfileDashboardModel> getProfileDashboard() async {
    try {
      final response = await _apiService.get('/v1/profile/me');

      final payload = _extractPayload(response);
      final profile = GuideProfileDashboardModel.fromJson(payload);

      await _cacheDashboardPayload(payload);
      await _cacheProfileInfo(
        firstName: profile.firstName,
        lastName: profile.lastName,
        email: profile.email,
        phone: profile.phone,
      );
      return profile;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<String> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    try {
      final response = await _apiService.put('/v1/profile/profile', {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': _normalizePhone(phone),
      });

      if (response is Map<String, dynamic> && response['success'] == false) {
        throw ApiException(
          response['message']?.toString() ?? 'Failed to update profile',
        );
      }

      await _cacheProfileInfo(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
      );
      await _updateCachedGuideName(firstName: firstName, lastName: lastName);

      if (response is Map<String, dynamic>) {
        final serverMessage = response['message']?.toString();
        if (serverMessage != null && serverMessage.trim().isNotEmpty) {
          return serverMessage;
        }
      }

      return 'Your profile has been updated successfully.';
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<String> deleteAccount() async {
    try {
      final response = await _apiService.delete('/v1/profile/delete-account');

      if (response is Map<String, dynamic>) {
        if (response['success'] == false) {
          throw ApiException(
            response['message']?.toString() ?? 'Failed to delete account',
          );
        }

        final serverMessage = response['message']?.toString().trim() ?? '';
        if (serverMessage.isNotEmpty) {
          return serverMessage;
        }
      }

      return 'Your account has been deactivated successfully.';
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Map<String, dynamic> _extractPayload(dynamic response) {
    if (response is! Map<String, dynamic>) {
      throw ApiException('Invalid profile response format');
    }

    if (response['data'] is Map<String, dynamic>) {
      return response['data'] as Map<String, dynamic>;
    }

    return response;
  }

  String _normalizePhone(String input) {
    var value = input.trim().replaceAll(' ', '');
    if (value.startsWith('+20')) {
      value = value.substring(3);
    }
    if (value.length == 10 && !value.startsWith('0')) {
      value = '0$value';
    }
    return value;
  }

  Future<GuideProfileDashboardModel?> getCachedProfileDashboard() async {
    try {
      final raw = await PrefHelper.getString(_dashboardCacheKey);
      if (raw == null || raw.trim().isEmpty) return null;

      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return null;

      return GuideProfileDashboardModel.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, String>> getCachedProfileInfo() async {
    try {
      final raw = await PrefHelper.getString(_profileInfoCacheKey);
      if (raw == null || raw.trim().isEmpty) return const {};

      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return const {};

      return {
        'firstName': (decoded['firstName'] ?? '').toString(),
        'lastName': (decoded['lastName'] ?? '').toString(),
        'email': (decoded['email'] ?? '').toString(),
        'phone': (decoded['phone'] ?? '').toString(),
      };
    } catch (_) {
      return const {};
    }
  }

  Future<void> _cacheDashboardPayload(Map<String, dynamic> payload) async {
    await PrefHelper.saveString(_dashboardCacheKey, jsonEncode(payload));
  }

  Future<void> _cacheProfileInfo({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    final normalizedPhone = _normalizePhone(phone);
    await PrefHelper.saveString(
      _profileInfoCacheKey,
      jsonEncode({
        'firstName': firstName.trim(),
        'lastName': lastName.trim(),
        'email': email.trim(),
        'phone': normalizedPhone,
      }),
    );
  }

  Future<void> _updateCachedGuideName({
    required String firstName,
    required String lastName,
  }) async {
    final raw = await PrefHelper.getString(_dashboardCacheKey);
    if (raw == null || raw.trim().isEmpty) return;

    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) return;

    decoded['guideName'] = _composeGuideName(firstName, lastName);
    await PrefHelper.saveString(_dashboardCacheKey, jsonEncode(decoded));
  }

  String _composeGuideName(String firstName, String lastName) {
    final first = firstName.trim();
    final last = lastName.trim();
    if (first.isEmpty && last.isEmpty) return '';
    if (first.isEmpty) return last;
    if (last.isEmpty) return first;
    return '$first $last';
  }
}
