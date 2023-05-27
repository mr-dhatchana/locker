import 'package:flutter/material.dart';

import '../helpers/sharedPreference.dart';
import '../repository/authentication.dart';
import '../widgets/app_Color.dart';
import '../widgets/textFields.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

TextEditingController _userName = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _rePasswordController = TextEditingController();

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  setColor('#161622'),
                  setColor('#1B1E23'),
                  setColor('#272738'),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CallTextField(
                      text: 'Enter Your Name',
                      isPassword: false,
                      icon: Icons.person,
                      controller: _userName),
                  const SizedBox(
                    height: 20,
                  ),
                  CallTextField(
                      text: 'Enter Your Name',
                      isPassword: false,
                      icon: Icons.mail,
                      controller: _emailController),
                  const SizedBox(
                    height: 20,
                  ),
                  CallTextField(
                    text: 'Enter Your Password',
                    isPassword: true,
                    icon: Icons.key,
                    controller: _passwordController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CallTextField(
                    text: 'Re-Enter Your Password',
                    isPassword: true,
                    icon: Icons.key,
                    controller: _rePasswordController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  signButton(context, false, () async {
                    final userName = _userName.text;
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final rePassword = _rePasswordController.text;
                    if ((password.toString()) == (rePassword.toString())) {
                      createUserWithMailPassword(
                          context, userName, email, password);
                      if (userName != null) {
                        await SharedPreference.setUserData(userName);
                      }
                    } else {
                      print('worng password');
                    }
                  }),
                  const SizedBox(
                    height: 40,
                  ),
                  goToSignUP(context, false),
                ],
              ),
            )),
      ),
    );
  }
}
