import 'package:flutter/material.dart';
import 'package:locker/models/userAppList.dart';
import 'package:locker/pages/createList.dart';
import 'package:locker/pages/detailsList.dart';
import 'package:locker/pages/editPage.dart';
import 'package:locker/pages/signIn.dart';

import 'pages/signUp.dart';

class RouteRedirect {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/SignIn':
        return MaterialPageRoute(builder: (_) => SignIn());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUp());
      case '/Home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/AddList':
        return MaterialPageRoute(builder: (_) => AddList());
      case '/EditPage':
        return MaterialPageRoute(
            builder: (_) => EditPage(lists: settings.arguments as UserAppList));
    }
  }
}
