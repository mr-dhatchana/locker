import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controller/details_Controller.dart';
import '../helpers/message.dart';
import '../helpers/sharedPreference.dart';

class Drawers extends StatefulWidget {
  Drawers({Key? key}) : super(key: key);

  @override
  _DrawersState createState() => _DrawersState();
}

class _DrawersState extends StateMVC<Drawers> {
  late final ListController _con;
  final globalKey = GlobalKey<ScaffoldState>();
  String? userName;
  late TextEditingController nameController = TextEditingController();

  _DrawersState() : super(ListController()) {
    _con = controller as ListController;
  }
  @override
  void initState() {
    _con.getMail();
    getName();

    super.initState();
  }

  timer() {
    return Future.delayed(Duration(seconds: 0), () {
      Scaffold.of(context).closeDrawer();
    });
  }

  Future<void> getName() async {
    final _userName = await SharedPreference.getUserData();
    setState(() => userName = _userName!);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromRGBO(39, 39, 56, 1),
      child: ListView(
        shrinkWrap: true,
        children: [
          CircleAvatar(
            backgroundColor: Color.fromRGBO(222, 88, 51, 1),
            radius: 35,
            child: Text(
              userName?[0].toUpperCase() ?? 'X',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    userName?.toUpperCase() ?? 'Edit Yours Name',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Color.fromRGBO(222, 88, 51, 0.8),
                ),
                onPressed: () async {
                  //timer();
                  await displayEditNameDialog(context);
                },
              ),
            ],
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.mail_sharp,
              color: Color.fromRGBO(222, 88, 51, 0.8),
            ),
            title: Text(
              //   _con.userList.first?.email ?? '',
              _con.meraName ?? '',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/SignIn');
            },
            leading:
                Icon(Icons.logout, color: Color.fromRGBO(222, 88, 51, 0.8)),
            title: Text(
              'Log out',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> displayEditNameDialog(BuildContext context) async {
    nameController.text = userName ?? '';
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Update Your\'s Name!!',
              style: TextStyle(
                color: Color.fromRGBO(255, 87, 51, 1),
              ),
            ),
            content: TextField(
              // onChanged: (value) {
              //   setState(() {
              //   });
              // },
              autofocus: true,
              cursorColor: const Color.fromRGBO(255, 87, 51, 1),

              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Enter name",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(255, 87, 51, 1), width: 2.0),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text(
                  'OK',
                  style: TextStyle(color: Color.fromRGBO(222, 88, 51, 1)),
                ),
                onPressed: () async {
                  _con.updateName(nameController.text);
                  await SharedPreference.setUserData(nameController.text);
                  showMessage("Name Updated", context);
                  setState(() {
                    Navigator.pop(context);
                  });
                  await timer();
                },
              ),
            ],
          );
        });
  }
}
