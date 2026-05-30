import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/core/network/api_service.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/data/model/tourist_basic_info_model.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/data/model/tourist_travel_info_model.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/data/model/tourist_travel_interests_model.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/data/model/tourist_preferences_model.dart';
import 'package:dio/dio.dart';

class CompleteTouristAccountRepo {
  final ApiService _apiService;
  CompleteTouristAccountRepo(this._apiService);

  Future<Map<String, dynamic>> submitBasicInfo(
    TouristBasicInfoModel model,
  ) async {
    try {
      final response = await _apiService.post(
        '/tourist/profile/basic-info',
        model.toJson(),
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Map<String, dynamic>> getBasicInfo() async {
    try {
      final response = await _apiService.get('/tourist/profile/SingUpDetails');
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Map<String, dynamic>> submitTravelInfo(
    TouristTravelInfoModel model,
  ) async {
    try {
      final response = await _apiService.post(
        '/tourist/profile/travel-info',
        model.toJson(),
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Map<String, dynamic>> submitTravelInterests(
    TouristTravelInterestsModel model,
  ) async {
    try {
      final response = await _apiService.post(
        '/tourist/profile/interests',
        model.toJson(),
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Map<String, dynamic>> submitPreferences(
    TouristPreferencesModel model,
  ) async {
    try {
      final response = await _apiService.post(
        '/tourist/profile/preferences',
        model.toJson(),
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Map<String, dynamic>> uploadProfilePhoto(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });
      final response = await _apiService.post(
        '/tourist/profile/photo',
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
