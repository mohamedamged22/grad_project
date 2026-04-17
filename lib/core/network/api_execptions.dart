import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => message;

  factory ApiException.fromDioError(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;
    final data = response?.data;

    switch (error.type) {
      // ===============================
      // ⏱ Timeouts
      // ===============================
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('api_connection_timeout'.tr(), 408);

      // ===============================
      // 🌐 No Internet
      // ===============================
      case DioExceptionType.connectionError:
        return ApiException('api_no_internet'.tr());

      case DioExceptionType.cancel:
        return ApiException('api_request_cancelled'.tr());

      // ===============================
      // 🚫 Server responded with error
      // ===============================
      case DioExceptionType.badResponse:
        // -------- JSON response --------
        if (data is Map<String, dynamic>) {
          final serverMessage =
              data['message']?.toString() ?? data['error']?.toString();

          switch (statusCode) {
            case 401:
              return ApiException(
                serverMessage ?? 'api_bad_credentials'.tr(),
                401,
              ); // BadCredentialsException
            case 404:
              return ApiException(
                serverMessage ?? 'api_user_not_found'.tr(),
                404,
              ); // UserNotFoundException
            case 409:
              return ApiException(
                serverMessage ?? 'api_email_already_used'.tr(),
                409,
              ); // UserAlreadyExistsException
            case 400:
              return ApiException(serverMessage ?? 'api_bad_request'.tr(), 400);
            case 403:
              return ApiException(
                serverMessage ?? 'api_access_denied'.tr(),
                403,
              );
            case 500:
              return ApiException(
                serverMessage ?? 'api_server_error'.tr(),
                500,
              );
            default:
              return ApiException(
                serverMessage ?? 'api_something_wrong'.tr(),
                statusCode,
              );
          }
        }

        // -------- Plain text / HTML --------
        if (data is String) {
          if (data.toLowerCase().contains('<!doctype html>')) {
            return ApiException('api_unexpected_response'.tr(), statusCode);
          }
          return ApiException(data, statusCode);
        }

        // -------- Status code fallback --------
        switch (statusCode) {
          case 401:
            return ApiException('api_bad_credentials'.tr(), 401);
          case 404:
            return ApiException('api_user_not_found'.tr(), 404);
          case 409:
            return ApiException('api_user_already_exists'.tr(), 409);
          default:
            return ApiException('api_something_wrong'.tr(), statusCode);
        }

      // ===============================
      // 🔐 SSL
      // ===============================
      case DioExceptionType.badCertificate:
        return ApiException('api_bad_ssl'.tr());

      case DioExceptionType.unknown:
        return ApiException('api_unexpected_error'.tr());
    }
  }
}
