import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendactshow extends StatefulWidget {
  final QuerySnapshot snapshot;
  final int index;

  const Calendactshow({Key key, this.snapshot, this.index}) : super(key: key);

  @override
  _CalendactshowState createState() => _CalendactshowState();
}

class _CalendactshowState extends State<Calendactshow> {
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var snapshotData = widget.snapshot.docs[widget.index].data;
    var docID = widget.snapshot.docs[widget.index].id;
    var snapshotName = widget.snapshot.docs[widget.index].get('name');

    var snapshotBarva = widget.snapshot.docs[widget.index].get('barva');
    var snapshotDate = widget.snapshot.docs[widget.index].get('date');
    var snapshotTime = widget.snapshot.docs[widget.index].get('time');

    _AppointmentDataSource _getCalendarDataSource(
        QuerySnapshot snapshot, int index) {
      List<Appointment> appointments = <Appointment>[];
      appointments.add(Appointment(
        startTime: DateTime(snapshotDate, snapshotTime),
        endTime:
            DateTime(snapshotDate, snapshotTime).add(Duration(minutes: 55)),
        subject: snapshotName,
        color: snapshotBarva,
        startTimeZone: '',
        endTimeZone: '',
      ));
      return _AppointmentDataSource(appointments);
    }
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
