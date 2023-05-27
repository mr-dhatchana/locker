import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controller/details_Controller.dart';

class AddList extends StatefulWidget {
  AddList({Key? key}) : super(key: key);

  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends StateMVC<AddList> {
  TextEditingController appName = TextEditingController();
  TextEditingController appUserName = TextEditingController();
  TextEditingController appPassword = TextEditingController();
  late final ListController _con;
  final _formKey = GlobalKey<FormState>();

  _AddListState() : super(ListController()) {
    _con = controller as ListController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(39, 39, 56, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(222, 88, 51, 1),
        title: Text('Add Your App List'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter App Name';
                    }
                    return null;
                  },
                  controller: appName,
                  cursorColor: const Color.fromRGBO(222, 88, 51, 0.8),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.app_blocking_outlined,
                      color: Color.fromRGBO(222, 88, 51, 0.8),
                    ),
                    hintText: 'App Name',
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(223, 225, 232, 1),
                    ),
                    fillColor: Color.fromRGBO(22, 22, 34, 1),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter UserId';
                    }
                    return null;
                  },
                  controller: appUserName,
                  cursorColor: const Color.fromRGBO(222, 88, 51, 0.8),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person_add_alt,
                      color: Color.fromRGBO(222, 88, 51, 0.8),
                    ),
                    hintText: 'Email/Phone/User Name',
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(223, 225, 232, 1),
                    ),
                    fillColor: Color.fromRGBO(22, 22, 34, 1),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                  controller: appPassword,
                  cursorColor: const Color.fromRGBO(222, 88, 51, 0.8),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Color.fromRGBO(222, 88, 51, 0.8),
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(223, 225, 232, 1),
                    ),
                    fillColor: Color.fromRGBO(22, 22, 34, 1),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.height,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _con.saveData(
                            appName.text, appUserName.text, appPassword.text);
                        Navigator.of(context).pushReplacementNamed('/Home');
                      }
                    },
                    child: Text(
                      'Save',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
