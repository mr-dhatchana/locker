import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locker/helpers/helper.dart';
import 'package:locker/models/personalDetails.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../helpers/message.dart';
import '../models/userAppList.dart';
import '../repository/authentication.dart';

class ListController extends ControllerMVC {
  bool loading = false;
  late OverlayEntry loader;

  ListController() {
    loader = Helper.overlayLoader(state?.context);
  }

  List<UserAppList?> dataList = [];
  List<PersonalDetails?> userList = [];
  String? meraName;

  Future<void> listenForList({String? message}) async {
    final context = state?.context;
    if (!await Helper.hasConnection()) {
      showNoInternetMessage(context);
    }
    if (context != null) {
      Overlay.of(context).insert(loader);
    }
    final result = await getCurrentUserDetails();
    Helper.hideLoader(loader);

    setState(() {
      dataList.addAll((result ?? []) as Iterable<UserAppList?>);
    });
    print(dataList);
  }

  Future<void> refreshListenForList() async {
    dataList.clear();
    listenForList();
  }

  Future<void> saveData(
    String appName,
    String appUserName,
    String appPassword,
  ) async {
    final context = state?.context;

    String? changeMonth;
    DateTime now = DateTime.now();
    changeMonth = now.month.toString();

    if (now.month <= 10) {
      changeMonth = '0${now.month}';
    }

    final update = '-';
    if (!await Helper.hasConnection()) {
      showNoInternetMessage(context);
    }
    Map<String, dynamic> appInfo = {
      'appName': appName,
      'appUserName': appUserName,
      'appPassword': appPassword,
      'createdAt': '${now.day}/${changeMonth}/${now.year}',
      'updatedAt': update,
    };
    if (context != null) {
      Overlay.of(context).insert(loader);
    }
    await addAppList(appInfo);
    Helper.hideLoader(loader);
  }

  Future<void> updateData(
      String? appName, String? appUserName, String? appPassword) async {
    final context = state?.context;
    DateTime now = DateTime.now();
    String? changeMonth;
    changeMonth = now.month.toString();
    if (now.month <= 10) {
      changeMonth = '0${now.month}';
    }
    final date = '${now.day}/${changeMonth}/${now.year}';
    if (!await Helper.hasConnection()) {
      showNoInternetMessage(context);
    }
    Map<String, dynamic> appInfo = {
      'appName': appName,
      'appUserName': appUserName,
      'appPassword': appPassword,
      'updatedAt': date,
    };

    if (context != null) {
      Overlay.of(context).insert(loader);
    }
    await updateAppList(appInfo);
    Helper.hideLoader(loader);
  }

  Future<void> updateName(
    String? name,
  ) async {
    final context = state?.context;
    if (!await Helper.hasConnection()) {
      showNoInternetMessage(context);
    }
    Map<String, dynamic> appInfo = {
      'userName': name,
    };
    if (context != null) {
      Overlay.of(context).insert(loader);
    }
    await updateUserName(appInfo);
    Helper.hideLoader(loader);
  }

  Future<String?> getMail() async {
    final userId = await FirebaseAuth.instance.currentUser!.email;
    print(userId);
    setState(() {
      meraName = userId;
    });
  }
}
