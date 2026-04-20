import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String _tokenKey = 'auth_token';
  static const String _roleKey = 'user_role';
  static const String _profileCompletedKey = 'profile_completed';
  static const String _guideDashboardCacheKey = 'guide_dashboard_cache';
  static const String _guideProfileInfoCacheKey = 'guide_profile_info_cache';

  static Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> removeKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<void> saveUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }

  static Future<void> setProfileCompleted(bool isCompleted) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_profileCompletedKey, isCompleted);
  }

  static Future<bool> isProfileCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_profileCompletedKey) ?? false;
  }

  static Future<void> clearAuthMetadata() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_roleKey);
    await prefs.remove(_profileCompletedKey);
  }

  static Future<void> clearSession() async {
    await clearToken();
    await clearAuthMetadata();
    await removeKey(_guideDashboardCacheKey);
    await removeKey(_guideProfileInfoCacheKey);
  }
}
