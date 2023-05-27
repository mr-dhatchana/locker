import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/userAppList.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future<User?> getCurrentUser() async {
  return await auth.currentUser;
}

Future<void> createUserWithMailPassword(
  BuildContext context,
  String userName,
  String email,
  String password,
) async {
  UserCredential userCredential = await auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  Map<String, dynamic> userInfo = {
    'userName': userName,
    'email': email,
    'password': password,
  };

  if (userCredential != null) {
    addUserToDb(auth.currentUser!.uid, userInfo);
    Navigator.of(context).pushReplacementNamed('/Home');
  } else {
    print('something went wrong');
  }
}

Future<void> loginWithUserMailPassword(
    BuildContext context, String email, String password) async {
  try {
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        Navigator.of(context).pushReplacementNamed('/Home');
      },
    );
  } on FirebaseAuthException catch (e) {
    print(e);
    if (e.message != null) {
      print(e.code);
    }
  }
}

Future<void> logOut() async {
  await auth.signOut();
}

Future addUserToDb(String userId, Map<String, dynamic> userInfo) {
  return FirebaseFirestore.instance
      .collection('user')
      .doc(userId)
      .set(userInfo);
}

Future addAppList(Map<String, dynamic> appInfo) {
  final userId = auth.currentUser!.uid;
  return FirebaseFirestore.instance
      .collection('user')
      .doc(userId)
      .collection('AppList')
      .doc(appInfo['appName'])
      .set(appInfo);
}

Future updateAppList(Map<String, dynamic> appInfo) {
  final userId = auth.currentUser!.uid;
  return FirebaseFirestore.instance
      .collection('user')
      .doc(userId)
      .collection('AppList')
      .doc(appInfo['appName'])
      .update(appInfo);
}


Future updateUserName(Map<String, dynamic> appUser) {
  final userId = auth.currentUser!.uid;
  return FirebaseFirestore.instance
      .collection('user')
      .doc(userId)
      .update(appUser);
}

Future<List?> getCurrentUserDetails() async {
  final userId = auth.currentUser!.uid;
  final QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
      .instance
      .collection('user')
      .doc(userId)
      .collection('AppList')
      .get();

  final dataFromFirebase = data.docs;
  List<UserAppList> appList = [];
  appList =
      dataFromFirebase.map((e) => UserAppList.fromJson(e.data())).toList();

  return appList;
}

Future<void> deleteFromList(currentAppName) async {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore.instance
      .collection('user')
      .doc(userId)
      .collection('AppList')
      .doc(currentAppName)
      .delete()
      .then((value) => print('Document deleted successfully.'))
      .catchError((error) => print('Failed to delete document: $error'));
}

// Future<PersonalDetails?> getUserfromDb() async {
//   final userId = auth.currentUser!.uid;
//   DocumentSnapshot<Map<String, dynamic>> data =
//       await FirebaseFirestore.instance.collection('user').doc(userId).get();
//
//   final userDataList =
//       await PersonalDetails.fromJson(data.data() as Map<String, dynamic>);
//   return userDataList;
// }
