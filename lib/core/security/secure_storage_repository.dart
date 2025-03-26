import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plannify/core/security/storage_key.dart';

class SecureStorageManager {

   final FlutterSecureStorage _storage = FlutterSecureStorage();

  //!------------------------------------------------------ Token
   Future<void> saveAuthToken(String token) async =>
      await _storage.write(key: StorageKeyManager.authTokenKey, value: token);

   Future<String?> getAuthToken() async =>
      await _storage.read(key: StorageKeyManager.authTokenKey);

  //!------------------------------------------------------ User ID
   Future<void> saveUserId(String userId) async =>
      await _storage.write(key: StorageKeyManager.userIdKey, value: userId);

   Future<String?> getUserId() async =>
      await _storage.read(key: StorageKeyManager.userIdKey);

  //* ------------------------------------------------------ User Data
   Future<void> clearUserData() async {
    await _storage.delete(key: StorageKeyManager.authTokenKey);
    await _storage.delete(key: StorageKeyManager.userIdKey);
  }

  //!------------------------------------------------------ Theme Mode
   Future<void> saveThemeMode(bool isDarkMode) async => await _storage
      .write(key: StorageKeyManager.themeModeKey, value: isDarkMode.toString());

   Future<bool?> getThemeMode() async {
    final value = await _storage.read(key: StorageKeyManager.themeModeKey);
    return value?.toLowerCase() == 'true';
  }

  //!------------------------------------------------------ Localization
   Future<void> saveLocalization(String locale) async => await _storage
      .write(key: StorageKeyManager.localizationKey, value: locale);

   Future<String?> getLocalization() async =>
      await _storage.read(key: StorageKeyManager.localizationKey);

  //?------------------------------------------------------ General Methods
   Future<void> clearAll() async => await _storage.deleteAll();

   Future<void> writeData(String key, String value) async =>
      await _storage.write(key: key, value: value);

   Future<String?> readData(String key) async =>
      await _storage.read(key: key);

   Future<void> deleteData(String key) async =>
      await _storage.delete(key: key);

   Future<bool> containsKey(String key) async =>
      await _storage.containsKey(key: key);
}
