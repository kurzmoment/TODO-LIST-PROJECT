import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todoList/ui/backDropAddActvity.dart';
import 'package:we_slide/we_slide.dart';
import 'package:todoList/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAct extends StatefulWidget {
  @override
  _AddActState createState() => _AddActState();
}

// PORAD NEFUNGUJE TAK JAK BY MELO
// jebeti
class _AddActState extends State<AddAct> {
  @override
  Widget build(BuildContext context) {
    final double _panelMinSize = 60.0;
    final double _panelMaxSize = MediaQuery.of(context).size.height / 1.2;
    return Scaffold(
      body: WeSlide(
        controller: WeSlideController(),
        blur: true,
        panelMinSize: _panelMinSize,
        panelMaxSize: _panelMaxSize,
        body: HomeScreen(),
        panel: Scaffold(
          // appBar: AppBar(
          //   actions: [
          //     Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: IconButton(
          //           icon: Icon(Icons.save),
          //           onPressed: () => debugPrint('saved'),
          //         ))
          //   ],
          // ),
          body: AddActForms(),
        ),
        panelHeader: Container(
          alignment: Alignment.center,
          child: Text(
            'Add activity',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          color: Colors.blue,
          height: _panelMinSize,
        ),
        parallax: true,
        bodyBorderRadiusBegin: 20,
        panelBorderRadiusEnd: 20,
        parallaxOffset: 0,
        overlayOpacity: 10,
        hidePanelHeader: false,
      ),
    );
  }
}
