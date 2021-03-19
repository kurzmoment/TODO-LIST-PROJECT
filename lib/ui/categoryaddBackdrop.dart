import 'dart:ui';

import 'package:flutter/material.dart';
import 'categoryaddBackdropp.dart';

import 'package:todoList/ui/categ.dart';
import 'package:todoList/ui/categoryaddBackdropp.dart';
import 'package:we_slide/we_slide.dart';
import 'categ.dart';

class AddCat extends StatefulWidget {
  @override
  _AddCatState createState() => _AddCatState();
}

// PORAD NEFUNGUJE TAK JAK BY MELO
// jebeti
class _AddCatState extends State<AddCat> {
  @override
  Widget build(BuildContext context) {
    final double _panelMinSize = 60.0;
    final double _panelMaxSize = MediaQuery.of(context).size.height / 1.5;
    return Scaffold(
      body: WeSlide(
        controller: WeSlideController(),
        panelMinSize: _panelMinSize,
        panelMaxSize: _panelMaxSize,
        body: Categoryscreen(),
        panel: Scaffold(body: AddCatForms()),
        panelHeader: Container(
          alignment: Alignment.center,
          child: Text(
            'Add category',
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

// class AddCatfromact extends StatefulWidget {
//   @override
//   _AddCatStatefromact createState() => _AddCatStatefromact();
// }

// class _AddCatStatefromact extends State<AddCatfromact> {
//   @override
//   Widget build(BuildContext context) {
//     final double _panelMinSize = 60.0;
//     final double _panelMaxSize = MediaQuery.of(context).size.height / 1.5;
//     return Scaffold(
//       body: WeSlide(
//         controller: WeSlideController(),
//         panelMinSize: _panelMinSize,
//         panelMaxSize: _panelMaxSize,
//         body: ListOfActivities(),
//         panel: Scaffold(
//           body: AddActForms(),
//         ),
//         panelHeader: Container(
//           alignment: Alignment.center,
//           child: Text(
//             'Add category',
//             style: TextStyle(fontSize: 20, color: Colors.white),
//           ),
//           color: Colors.blue,
//           height: _panelMinSize,
//         ),
//         // BLUR
//         blurSigma: 0.75,
//         blur: true,
//         //transformScale: true,
//         //transformScaleEnd: 0.95,
//         // BLUR
//         parallax: true,
//         bodyBorderRadiusBegin: 20,
//         panelBorderRadiusEnd: 20,
//         parallaxOffset: 0,
//         overlayOpacity: 10,
//         hidePanelHeader: false,
//       ),
//     );
//   }
// }
