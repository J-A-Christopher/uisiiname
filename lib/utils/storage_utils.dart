import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils{
    SharedPreferences? storage;

  Future<void> writeUserInfo(
      {required String key, required dynamic userInfo}) async {
    storage = await SharedPreferences.getInstance();

    await storage?.setString(key, userInfo.toString());
  }

  Future<void> logoutUser() async {
    storage = await SharedPreferences.getInstance();
    await storage?.clear();
  }

  Future<String?> getUserInfo({required String key}) async {
    storage = await SharedPreferences.getInstance();

    String? userinfo = storage?.getString(key);

    return userinfo;
  }
}