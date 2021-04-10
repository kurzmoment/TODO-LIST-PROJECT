import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:todoList/ui/backDropAddActvity.dart';
import 'package:todoList/util/app_localizations.dart';
import 'package:we_slide/we_slide.dart';
import 'package:todoList/home.dart';

class AddAct extends StatefulWidget {
  @override
  _AddActState createState() => _AddActState();
}

class _AddActState extends State<AddAct> {
  @override
  Widget build(BuildContext context) {
    final double _panelMinSize = 60.0;
    final double _panelMaxSize = MediaQuery.of(context).size.height / 1.15;
    return Scaffold(
      body: WeSlide(
        controller: WeSlideController(),
        panelMinSize: _panelMinSize,
        panelMaxSize: _panelMaxSize,
        body: Home(),
        panel: Scaffold(
          body: AddActForms(),
        ),
        panelHeader: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          height: _panelMinSize,
          child: Text(
            AppLocalizations.of(context).translate('addActivity'),
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        blurSigma: 0.75,
        blur: true,
        panelBorderRadiusBegin: 0,
        panelBorderRadiusEnd: 25,
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
    final double _panelMaxSize = MediaQuery.of(context).size.height / 1.15;
    return Scaffold(
      body: WeSlide(
        controller: WeSlideController(),
        panelMinSize: _panelMinSize,
        panelMaxSize: _panelMaxSize,
        body: Home(),
        panel: Scaffold(
          body: AddActForms(),
        ),
        panelHeader: Container(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context).translate('addActivity'),
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
