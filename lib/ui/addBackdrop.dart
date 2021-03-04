import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';

class AddAct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      frontLayer: Container(
        child: Text('BackDrop'),
      ),
    );
  }
}
