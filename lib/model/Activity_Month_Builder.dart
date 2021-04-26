import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:todoList/model/Activity_Today_Show.dart';

class ActivityMonthBuilder extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    DateTime today = new DateTime.now();
    var datum = DateFormat("dd/MM/yyyy").format(today);
    var dt = DateFormat("dd/MM/yyyy").parse(datum);

    var n = dt.millisecondsSinceEpoch.toString();

    var datumm = DateFormat("dd/MM/yyyy").format(findLastDateOfTheWeek(today));

    var dtt = DateFormat("dd/MM/yyyy").parse(datumm);

    var nn = dtt.millisecondsSinceEpoch.toString();

    var datummm = DateFormat("dd/MM/yyyy").format(findLastDateOfMonth(today));
    var dttt = DateFormat("dd/MM/yyyy").parse(datummm);

    var nnn = dttt.millisecondsSinceEpoch.toString();

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('userData')
          .doc(auth.currentUser.uid)
          .collection('activity')
          .where("stampD", isGreaterThan: nn)
          .where("stampD", isLessThanOrEqualTo: nnn)
          .orderBy('stampD', descending: false)
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

DateTime findLastDateOfTheWeek(DateTime dateTimee) {
  return dateTimee
      .add(Duration(days: DateTime.daysPerWeek - dateTimee.weekday));
}

DateTime findLastDateOfMonth(DateTime dateTime) {
  dateTime = new DateTime(dateTime.year, dateTime.month + 1, 0);
  return dateTime;
}
