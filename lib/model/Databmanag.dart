import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:intl/intl.dart';
import 'package:todoList/util/app_localizations.dart';
import 'package:we_slide/we_slide.dart';
import '../home.dart';

class DatabaseManager {
  final CollectionReference aktivlist = FirebaseFirestore.instance
      .collection('userData')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('activity');

  Future getUserlist() async {
    List idlist = [];
    //  Map<String, String> idlist = {};

    try {
      await aktivlist
          .where("ocurence", isEqualTo: "true")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          idlist.add(element.get("ocureid"));
          idlist.add(element.id);
          idlist.add(element.get("date"));
          //  idlist.addAll(
          //    {"ocure id": element.get("ocureid"), "idval": element.id});
        });
      });
      return idlist;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
