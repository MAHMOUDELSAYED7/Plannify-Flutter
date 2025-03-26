import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plannify/core/security/storage_key.dart';

class SecureStorageManager {
  const SecureStorageManager._();

  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  //!------------------------------------------------------ Token
  static Future<void> saveAuthToken(String token) async =>
      await _storage.write(key: StorageKeyManager.authTokenKey, value: token);

  static Future<String?> getAuthToken() async =>
      await _storage.read(key: StorageKeyManager.authTokenKey);

  //!------------------------------------------------------ User ID
  static Future<void> saveUserId(String userId) async =>
      await _storage.write(key: StorageKeyManager.userIdKey, value: userId);

  static Future<String?> getUserId() async =>
      await _storage.read(key: StorageKeyManager.userIdKey);

  //* ------------------------------------------------------ User Data
  static Future<void> clearUserData() async {
    await _storage.delete(key: StorageKeyManager.authTokenKey);
    await _storage.delete(key: StorageKeyManager.userIdKey);
  }

  //!------------------------------------------------------ Theme Mode
  static Future<void> saveThemeMode(bool isDarkMode) async => await _storage
      .write(key: StorageKeyManager.themeModeKey, value: isDarkMode.toString());

  static Future<bool?> getThemeMode() async {
    final value = await _storage.read(key: StorageKeyManager.themeModeKey);
    return value?.toLowerCase() == 'true';
  }

  //!------------------------------------------------------ Localization
  static Future<void> saveLocalization(String locale) async => await _storage
      .write(key: StorageKeyManager.localizationKey, value: locale);

  static Future<String?> getLocalization() async =>
      await _storage.read(key: StorageKeyManager.localizationKey);

  //?------------------------------------------------------ General Methods
  static Future<void> clearAll() async => await _storage.deleteAll();

  static Future<void> writeData(String key, String value) async =>
      await _storage.write(key: key, value: value);

  static Future<String?> readData(String key) async =>
      await _storage.read(key: key);

  static Future<void> deleteData(String key) async =>
      await _storage.delete(key: key);

  static Future<bool> containsKey(String key) async =>
      await _storage.containsKey(key: key);
}
