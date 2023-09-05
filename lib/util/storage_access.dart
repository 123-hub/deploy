import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageAccess {
  static const storage = FlutterSecureStorage();

  static Future<String?> getRole() async {
    return await storage.read(key: "role");
  }

  static Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  static Future<String?> getRefreshToken() async {
    return await storage.read(key: "refreshToken");
  }

  static Future deleteValues() async {
    await storage.deleteAll();
  }
}
