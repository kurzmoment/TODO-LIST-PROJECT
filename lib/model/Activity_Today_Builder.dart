import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:todoList/model/Activity_Today_Show.dart';

class ActivityTodayBuilder extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    DateTime today = new DateTime.now();
    var datum = DateFormat("dd/MM/yyyy").format(today);
    var dt = DateFormat("dd/MM/yyyy").parse(datum);

    var n = dt.millisecondsSinceEpoch.toString();

    var m = DateFormat("hh:mm a").format(today);
    var o = DateFormat("hh:mm a").parse(m);
    var g = o.millisecondsSinceEpoch.toString();
    print(m);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('userData')
          .doc(auth.currentUser.uid)
          .collection('activity')
          .where("stampD", isEqualTo: n)
          .where("stampT", isLessThan: g)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Container(
            width: 0,
            height: 0,
          );

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, int index) {
            return ActivityTodayShow(
              snapshot: snapshot.data,
              index: index,
            );
          },
        );
      },
    );
  }
}
