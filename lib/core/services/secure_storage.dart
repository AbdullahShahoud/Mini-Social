import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageToken {
  static FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();

  static setSecureString(String key, String value) async {
    await flutterSecureStorage.write(key: key, value: value);
  }

  static Future<String?> getSecureString(String key) async {
    return await flutterSecureStorage.read(key: key);
  }

  static clearAllSecuredData() async {
    await flutterSecureStorage.deleteAll();
  }
}
