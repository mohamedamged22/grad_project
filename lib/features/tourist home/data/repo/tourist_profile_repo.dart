import 'dart:convert';

import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/network/api_service.dart';
import 'package:beyond_the_pramids/core/utils/pref_helper.dart';
import 'package:dio/dio.dart';

class TouristProfileRepo {
  final ApiService _apiService;

  TouristProfileRepo(this._apiService);

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _apiService.get('/auth/me');
      await PrefHelper.saveAuthMeCache(jsonEncode(response));
      return _extractAuthMePayload(response);
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

      try {
        await getProfile();
      } catch (_) {
        // Ignore refresh errors to avoid blocking a successful update.
      }

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

  Map<String, dynamic> _extractAuthMePayload(dynamic response) {
    if (response is! Map<String, dynamic>) {
      throw ApiException('Invalid profile response format');
    }

    final rawData = response['data'];
    final payload = rawData is Map<String, dynamic> ? rawData : response;

    final touristData = payload['touristProfile'] as Map<String, dynamic>?;
    final user = payload['user'] as Map<String, dynamic>?;

    final name =
        touristData?['name']?.toString() ??
        user?['name']?.toString() ??
        user?['username']?.toString() ??
        '';
    final nameParts = name.trim().split(RegExp(r'\s+'));
    final firstName = nameParts.isNotEmpty ? nameParts.first : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return {
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'email':
          touristData?['email']?.toString() ?? user?['email']?.toString() ?? '',
      'phone': touristData?['phone']?.toString() ?? '',
      'destinationCity': touristData?['destinationCity']?.toString() ?? '',
      'profilePhoto':
          touristData?['profilePhoto']?.toString() ??
          user?['profilePhoto']?.toString(),
    };
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
}
