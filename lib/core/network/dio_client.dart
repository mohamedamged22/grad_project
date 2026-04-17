import 'package:beyond_the_pramids/core/utils/pref_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://josphine-magnipotent-vectorially.ngrok-free.dev/api',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
      },
    ),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // ⭐ جيب التوكن وحطّه في الـ Authorization header
          final token = await PrefHelper.getToken();
          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
            debugPrint('🔑 Token added: ${token.substring(0, 20)}...');
          } else {
            debugPrint('⚠️ No token found');
          }

          // Print request details
          debugPrint('🌐 ${options.method} ${options.path}');
          if (options.data != null) {
            debugPrint('📤 Request Data: ${options.data}');
          }
          if (options.queryParameters.isNotEmpty) {
            debugPrint('📋 Query Params: ${options.queryParameters}');
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Print response details
          debugPrint('✅ Response [${response.statusCode}]: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          // Print error details
          debugPrint('❌ Error [${error.response?.statusCode}]');
          debugPrint('Error Data: ${error.response?.data}');
          debugPrint('Error Message: ${error.message}');

          // ⭐ If 401 or 403, clear the token
          if (error.response?.statusCode == 401 ||
              error.response?.statusCode == 403) {
            debugPrint('🔓 Unauthorized - Token might be expired');
            // يمكن تمسح التوكن هنا لو عايزة
            // PrefHelper.clearToken();
          }

          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
