import 'package:flutter_dotenv/flutter_dotenv.dart';

class StorageKeyManager {
  const StorageKeyManager._();

  static String authTokenKey = dotenv.env['AUTH_TOKEN']!;
  static String userIdKey = dotenv.env['USER_ID']!;
  static const String themeModeKey = 'theme_mode';
  static const String localizationKey = 'localization';
}
