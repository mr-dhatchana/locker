import 'package:flutter/material.dart';
import 'package:locker/models/userAppList.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controller/details_Controller.dart';
import '../helpers/message.dart';

class EditPage extends StatefulWidget {
  EditPage({Key? key, this.lists}) : super(key: key);
  final UserAppList? lists;

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends StateMVC<EditPage> {
  TextEditingController appName = TextEditingController();
  TextEditingController appUserName = TextEditingController();
  TextEditingController appPassword = TextEditingController();
  final updateKey = GlobalKey<FormState>();

  late final ListController _con;

  _EditPageState() : super(ListController()) {
    _con = controller as ListController;
  }
  @override
  void initState() {
    appName.text = widget.lists?.appName ?? '';
    appUserName.text = widget.lists?.appUserName ?? '';
    appPassword.text = widget.lists?.appPassword ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 39, 56, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(222, 88, 51, 1),
        title: Text(appName.text),
        centerTitle: true,
      ),
      body: Form(
        key: updateKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (value) => appUserName = value as TextEditingController,
                  onChanged: (value) =>
                  appUserName = value as TextEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter User id';
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
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(223, 225, 232, 1),
                    ),
                    fillColor: const Color.fromRGBO(22, 22, 34, 1),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (value) => appPassword = value as TextEditingController,
                  onChanged: (value) =>
                  appPassword = value as TextEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
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
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(223, 225, 232, 1),
                    ),
                    fillColor: const Color.fromRGBO(22, 22, 34, 1),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                  ),
                ),
                const SizedBox(
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
                          return const Color.fromRGBO(255, 87, 51, 0.5);
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

                    if(updateKey.currentState!.validate()){
                      _con.updateData(
                          appName.text, appUserName.text, appPassword.text);
                      Navigator.of(context).pushReplacementNamed('/Home');
                      showMessage('Updated Successfully', context);
                    }
                    },
                    child: const Text(
                      'Update Details',
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
