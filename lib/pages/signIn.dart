import 'package:flutter/material.dart';

import '../repository/authentication.dart';
import '../widgets/app_Color.dart';
import '../widgets/textFields.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

bool visible = true;
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CallTextField(
                    text: 'Enter Your Mail',
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
                signButton(context, true, () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  // final email = 'abcdef@gmail.com';
                  // final password = 'password';
                  loginWithUserMailPassword(
                    context,
                    email,
                    password,
                  );
                }),
                forgetPassword(),
                const SizedBox(
                  height: 40,
                ),
                goToSignUP(context, true),
              ],
            ),
          )),
    );
  }

  Row forgetPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Forget Password!!',
          style: TextStyle(
            color: Color.fromRGBO(255, 87, 51, 0.7),
          ),
        ),
      ],
    );
  }
}
