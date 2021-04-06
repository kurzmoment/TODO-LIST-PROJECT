import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todoList/home.dart';
import 'package:todoList/ui/addBackdrop.dart';

import 'package:todoList/ui/profilePage.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../hexcolor.dart';

// JAKYMKOLIV ZPUSOBEM ZOBRAZIT AKTIVITY V KALENDARI

class ListOfActivities extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;

  ListOfActivities({Key key, this.snapshot, this.index}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text('List of activities',
            style: Theme.of(context).textTheme.headline6),
      ),
      body: Calbuildr(),
      //Activity(),
      bottomNavigationBar: new BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AccPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.calendar_today_rounded),
              disabledColor: Colors.grey.shade700,
              onPressed: null,
            ),
            // IconButton(
            //   icon: Icon(Icons.album),
            //   onPressed: () {
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context) => Categoryscreen()));
            //   },
            // ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddActcal()),
          );
        },
      ),
    );
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}

DataSource _getCalendarDataSource(
  QuerySnapshot snapshot,
) {
  int index = 0;
  List<Appointment> appointments = <Appointment>[];
  for (var i = 0; i < snapshot.docs.length; i++) {
    var snapshotName = snapshot.docs[index].get('name');

    var snapshotBarva = snapshot.docs[index].get('barva');
    var snapshotDate = snapshot.docs[index].get('date');
    var snapshotTime = snapshot.docs[index].get('time');
    var snapshotETime = snapshot.docs[index].get('etime');
    var snapfordat = snapshotDate + " " + snapshotTime;
    var snapforEdat = snapshotDate + " " + snapshotETime;
    final dateFormat = DateFormat("dd/MM/yyyy hh:mm a");

    DateTime dateTimme = dateFormat.parse(snapfordat);
    DateTime edateTimme = dateFormat.parse(snapforEdat);

    final Map<String, Color> colorsMapping = {
      'red': Colors.red,
      'black': Colors.black,
      'blue': Colors.blue,
      'green': Colors.green,
      'pink': Colors.pink,
      'yellow': Colors.yellow,
      'lightBlue': Colors.lightBlue,
      'lightGreen': Colors.lightGreen,
      'purple': Colors.purple,
      'amberAccent': Colors.amberAccent
    };

    appointments.add(Appointment(
      startTime: dateTimme,
      endTime: edateTimme,
      subject: snapshotName,
      color: colorsMapping[snapshotBarva],
    ));
    index++;
  }

  return DataSource(appointments);
}

class Calbuildr extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('userData')
          .doc(auth.currentUser.uid)
          .collection('activity')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        return SfCalendar(
          showDatePickerButton: true,
          view: CalendarView.schedule,
          timeSlotViewSettings: TimeSlotViewSettings(
            startHour: 5,
            endHour: 22,
            timeIntervalHeight: 75,
            timeIntervalWidth: 60,
          ),
          dataSource: _getCalendarDataSource(
            snapshot.data,
          ),
        );
      },
    );
  }
}
