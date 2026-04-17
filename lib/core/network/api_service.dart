import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/network/dio_client.dart';
import 'package:dio/dio.dart';

class ApiService {
  final DioClient _dioClient;

  ApiService(this._dioClient);

  // GET
  Future<dynamic> get(
    String endPoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        endPoint,
        queryParameters: queryParams,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  //post
  Future<dynamic> post(
    String endPoint,
    dynamic body, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        endPoint,
        data: body,
        queryParameters: queryParameters, // ✅ هنا الدعم
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // PUT
  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // DELETE
  Future<dynamic> delete(String endPoint, {Map<String, dynamic>? body}) async {
    try {
      final response = await _dioClient.dio.delete(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}
