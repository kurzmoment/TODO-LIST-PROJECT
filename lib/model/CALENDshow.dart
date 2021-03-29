import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Calendactshow extends StatefulWidget {
  final QuerySnapshot snapshot;
  final int index;

  const Calendactshow({Key key, this.snapshot, this.index}) : super(key: key);

  @override
  _CalendactshowState createState() => _CalendactshowState();
}

class _CalendactshowState extends State<Calendactshow> {
  String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {}
}
