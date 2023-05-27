class PersonalDetails {
  String? userName;
  String? email;
  String? password;

  PersonalDetails();

  PersonalDetails.fromJson(Map<String, dynamic> jsonMap) {
    try {
      userName = jsonMap['userName'].toString();
      email = jsonMap['email'].toString();
      password = jsonMap['password'].toString();
    } catch (e) {
      userName = '';
      email = '';
      password = '';
    }
  }
}
