import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todoList/ui/backDropAddActvity.dart';
import 'package:todoList/ui/calendaryWithAct.dart';
import 'package:we_slide/we_slide.dart';
import 'package:todoList/home.dart';

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
    final double _panelMaxSize = MediaQuery.of(context).size.height / 1.5;
    return Scaffold(
      body: WeSlide(
        controller: WeSlideController(),
        panelMinSize: _panelMinSize,
        panelMaxSize: _panelMaxSize,
        body: HomeScreen(),
        panel: Scaffold(
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
        // BLUR
        blurSigma: 0.75,
        blur: true,
        //transformScale: true,
        //transformScaleEnd: 0.95,
        // BLUR
        parallax: false,
        bodyBorderRadiusBegin: 20,
        panelBorderRadiusEnd: 20,
        parallaxOffset: 0,
        overlayOpacity: 10,
        hidePanelHeader: false,
      ),
    );
  }
}

class AddActcal extends StatefulWidget {
  @override
  _AddActStatecal createState() => _AddActStatecal();
}

class _AddActStatecal extends State<AddActcal> {
  @override
  Widget build(BuildContext context) {
    final double _panelMinSize = 60.0;
    final double _panelMaxSize = MediaQuery.of(context).size.height / 1.5;
    return Scaffold(
      body: WeSlide(
        controller: WeSlideController(),
        panelMinSize: _panelMinSize,
        panelMaxSize: _panelMaxSize,
        body: ListOfActivities(),
        panel: Scaffold(
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
        // BLUR
        blurSigma: 0.75,
        blur: true,
        //transformScale: true,
        //transformScaleEnd: 0.95,
        // BLUR
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
