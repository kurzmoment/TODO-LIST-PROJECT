import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:todoList/home.dart';
import 'package:todoList/ui/activities.dart';

class AddAct extends StatefulWidget {
  @override
  _AddActState createState() => _AddActState();
}

// PORAD NEFUNGUJE TAK JAK BY MELO
class _AddActState extends State<AddAct> {
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      stickyFrontLayer: true,
      appBar: BackdropAppBar(
        bottomOpacity: 0,
        backgroundColor: Colors.transparent,
        title: Text('TOHLE NEHCI'),
      ),
      frontLayer: Scaffold(
        appBar: AppBar(),
        body: Text('TEST'),
      ),
      backLayer: HomeScreen(),
    );
  }
}
