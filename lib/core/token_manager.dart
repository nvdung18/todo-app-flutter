import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static String? _token;
  static const String _tokenKey = 'auth_token';

  // Get token từ memory trước, nếu không có thì load từ SharedPreferences
  static Future<String?> getToken() async {
    if (_token != null) {
      return _token;
    }

    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey);
    return _token;
  }

  // Set token vào cả memory và SharedPreferences
  static Future<void> setToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Clear token từ cả memory và SharedPreferences
  static Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Sync method để get token từ memory (dùng khi đã chắc chắn token đã được load)
  static String? getTokenSync() => _token;

  // Initialize token từ SharedPreferences khi app start
  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey);
  }
}
