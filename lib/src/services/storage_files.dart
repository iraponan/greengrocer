import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mixin StorageFiles {
  static const storage = FlutterSecureStorage();

  static Future<void> saveLocalData({
    required String key,
    required String data,
  }) async {
    await storage.write(key: key, value: data);
  }

  static Future<String?> getLocalData({required String key}) async {
    return await storage.read(key: key);
  }

  static Future<void> removeLocalData({required String key}) async {
    await storage.delete(key: key);
  }
}
