class UserAppList {
  String? appName;
  String? appUserName;
  String? appPassword;
  String? createdAt;
  String? updatedAt;

  UserAppList();

  UserAppList.fromJson(Map<String, dynamic> jsonMap) {
    try {
      appName = jsonMap['appName'].toString();
      appUserName = jsonMap['appUserName'].toString();
      appPassword = jsonMap['appPassword'].toString();
      createdAt = jsonMap['createdAt'].toString();
      updatedAt = jsonMap['updatedAt'].toString();
    } catch (e) {
      appName = '';
      appUserName = '';
      appPassword = '';
      createdAt = '';
      updatedAt = '';
    }
  }
}
