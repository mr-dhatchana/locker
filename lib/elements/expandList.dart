import 'package:flutter/material.dart';
import 'package:locker/helpers/helper.dart';
import 'package:locker/models/userAppList.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controller/details_Controller.dart';

class ExpandList extends StatefulWidget {
  ExpandList({
    Key? key,
    required this.lists,
  }) : super(key: key);
  final UserAppList? lists;
  final isEdit = true;

  @override
  _ExpandListState createState() => _ExpandListState();
}

class _ExpandListState extends StateMVC<ExpandList> {
  late final ListController _con;
  _ExpandListState() : super(ListController()) {
    _con = controller as ListController;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(22, 22, 34, 1),
      child: ExpansionTile(
        title: Text(
          widget.lists?.appName ?? '-',
          style: const TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
          ),
          //Color.fromRGBO(222, 88, 51, 1)),
        ),
        trailing: Wrap(
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Color.fromRGBO(222, 88, 51, 0.8),
                //Color.fromRGBO(223, 225, 232, 1),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/EditPage',
                  arguments: widget.lists,
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Color.fromRGBO(222, 88, 51, 0.8),
                //Color.fromRGBO(223, 225, 232, 1),
              ),
              onPressed: () {
                final currentAppName = widget.lists?.appName;
                // _con.deleteFromList(currentAppName);
                Helper.showAlertDialog(context, currentAppName);
              },
            ),
          ],
        ),
        children: <Widget>[
          ListTile(
            title: Row(
              children: [
                Text(
                  'USER ID        : ',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(223, 225, 232, 1)),
                ),
                Text(
                  widget.lists?.appUserName ?? '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Text(
                  'PASSWORD : ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(223, 225, 232, 1),
                  ),
                ),
                Text(
                  widget.lists?.appPassword ?? '-',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.green),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Created: ${widget.lists?.createdAt ?? '-'}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Updated: ${widget.lists?.updatedAt ?? '-'}',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
