import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'route_redirect.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/SignIn',
      onGenerateRoute: RouteRedirect.generateRoute,
      title: 'User App',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(222, 88, 51, 1),
      ),
      //home: const SignUp(),
    );
  }
}
