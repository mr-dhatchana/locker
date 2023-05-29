import 'package:flutter/material.dart';

class CallTextField extends StatefulWidget {
  CallTextField({
    Key? key,
    this.controller,
    this.text,
    this.isPassword,
    this.icon,
  }) : super(key: key);
  late TextEditingController? controller;
  final bool? isPassword;
  final IconData? icon;
  final String? text;

  @override
  State<CallTextField> createState() => _CallTextFieldState();
}

class _CallTextFieldState extends State<CallTextField> {
  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (value) => widget.controller = value as TextEditingController,
      onChanged: (value) => widget.controller = value as TextEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter valid Data';
        }
        return null;
      },
      controller: widget.controller,
      obscureText: _isButtonPressed,
      enableSuggestions: !(widget.isPassword ?? false),
      autocorrect: !(widget.isPassword ?? false),
      cursorColor: const Color.fromRGBO(255, 87, 51, 1),
      style: const TextStyle(
        color: Color.fromRGBO(223, 225, 232, 1),
        fontSize: 20,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icon,
          color: const Color.fromRGBO(222, 88, 51, 0.8),
        ),
        suffixIcon: (widget.isPassword ?? false)
            ? IconButton(
                icon: Icon(
                  (_isButtonPressed) ? Icons.visibility_off : Icons.visibility,
                  size: 28,
                  color: Color.fromRGBO(222, 88, 51, 0.6),
                ),
                onPressed: () {
                  setState(() {
                    _isButtonPressed = !_isButtonPressed;
                  });
                },
              )
            : null,
        hintText: widget.text,
        hintStyle: TextStyle(
          color: Color.fromRGBO(223, 225, 232, 1),
        ),
        fillColor: Color.fromRGBO(39, 39, 56, 1),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
      keyboardType: (widget.isPassword ?? false)
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }
}

Container signButton(BuildContext context, bool isLogIn, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.height,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Color.fromRGBO(255, 87, 51, 0.5);
          }
          return const Color.fromRGBO(222, 88, 51, 1);
        }),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      child: Text(
        isLogIn ? 'Log In' : 'Sign Up',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          fontSize: 17,
        ),
      ),
    ),
  );
}

Row goToSignUP(BuildContext context, bool islog) {
  final txt = islog ? 'Don\'t Have Account?' : 'Already Have Account?';
  final signInUp = islog ? ' Sign Up' : ' Log In';
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        txt,
        style: const TextStyle(
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushReplacementNamed(islog ? '/SignUp' : '/SignIn');
        },
        child: Text(
          signInUp,
          style: const TextStyle(
            color: Color.fromRGBO(222, 88, 51, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
