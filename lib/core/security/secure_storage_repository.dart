import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  //! Key constants
  static String authTokenKey = dotenv.env['AUTH_TOKEN']!;
  static String userIdKey = dotenv.env['USER_ID']!;
  static const String themeModeKey = 'theme_mode';

  //! Saves auth token securely
  static Future<void> saveAuthToken(String token) async =>
      await _storage.write(key: authTokenKey, value: token);

  //! Retrieves auth token
  static Future<String?> getAuthToken() async =>
      await _storage.read(key: authTokenKey);

  //! Saves user ID
  static Future<void> saveUserId(String userId) async =>
      await _storage.write(key: userIdKey, value: userId);

  //! Retrieves user ID
  static Future<String?> getUserId() async =>
      await _storage.read(key: userIdKey);

  //! Saves theme preference
  static Future<void> saveThemeMode(bool isDarkMode) async =>
      await _storage.write(key: themeModeKey, value: isDarkMode.toString());

  //! Retrieves theme preference
  static Future<bool?> getThemeMode() async {
    final value = await _storage.read(key: themeModeKey);
    return value?.toLowerCase() == 'true';
  }

  //! Clears all secure data (logout)
  static Future<void> clearAll() async => await _storage.deleteAll();

  //! original implementations
  static Future<void> writeData(String key, String value) async =>
      await _storage.write(key: key, value: value);

  static Future<String?> readData(String key) async =>
      await _storage.read(key: key);

  static Future<void> deleteData(String key) async =>
      await _storage.delete(key: key);

  static Future<bool> containsKey(String key) async =>
      await _storage.containsKey(key: key);
}
