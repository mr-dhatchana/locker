import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static Future<bool> setUserData(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString('userDataName', name);
  }

  static Future<String?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String currentUserName = await prefs.getString('userDataName').toString();
    return currentUserName;
  }
}
