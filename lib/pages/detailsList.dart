import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controller/details_Controller.dart';
import '../elements/drawers.dart';
import '../elements/expandList.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends StateMVC<Home> {
  late final ListController _con;
  final globalKey = GlobalKey<ScaffoldState>();
  String? nameData;
  late final resetName;

  _HomeState() : super(ListController()) {
    _con = controller as ListController;
  }

  @override
  void initState() {
    _con.listenForList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(39, 39, 56, 1),
      key: globalKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(222, 88, 51, 1),
        //Color.fromRGBO(22, 22, 34, 1),
        leading: IconButton(
          icon: Icon(
            Icons.sort,
          ),
          //  color: Color.fromRGBO(22, 22, 34, 1),
          onPressed: () async {
            globalKey.currentState?.openDrawer();
          },
        ),
        title: Text('Home'),
        centerTitle: true,
      ),
      drawerEnableOpenDragGesture: false,
      drawer: Drawers(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: _con.dataList.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpandList(
              lists: _con.dataList[index]!,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(222, 88, 51, 1),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pushNamed('/AddList');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
