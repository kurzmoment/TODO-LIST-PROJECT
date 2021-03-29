import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todoList/home.dart';
import 'package:todoList/ui/addBackdrop.dart';
import 'package:todoList/ui/categ.dart';
import 'package:todoList/ui/profilePage.dart';

import '../hexcolor.dart';

// JAKYMKOLIV ZPUSOBEM ZOBRAZIT AKTIVITY V KALENDARI
class ListOfActivities extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;

  final firebaseDB = FirebaseFirestore.instance.collection('test').snapshots();
  static var date = DateTime.now();
  final dateFormat = DateFormat('EEEE / dd.MM.yyyy').format(date);

  ListOfActivities({Key key, this.snapshot, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // var snapshotData = snapshot.documents[index].data;
    // var docID = snapshot.documents[index].documentID;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text('List of activities',
            style: Theme.of(context).textTheme.headline6),
      ),
      body: SfCalendar(
        showDatePickerButton: true,
        //dataSource: ,
        view: CalendarView.workWeek,
        dataSource: _getCalendarDataSource(),
        timeSlotViewSettings: TimeSlotViewSettings(
          startHour: 5,
          endHour: 22,
          timeIntervalHeight: 75,
          timeIntervalWidth: 60,
          nonWorkingDays: <int>[DateTime.sunday],
        ),
      ),
      //Activity(),
      bottomNavigationBar: new BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Home()));
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

_AppointmentDataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  appointments.add(Appointment(
    startTime: DateTime.now(),
    endTime: DateTime.now().add(Duration(minutes: 55)),
    subject: 'Meeting',
    color: Colors.blue,
    startTimeZone: '',
    endTimeZone: '',
  ));

  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

// class DataSource extends CalendarDataSource{
//   DataSource(List<Appointment> source){
//     appointments = source;
//   }
// }

// DataSource _getCalendarDataSource(QuerySnapshot snapshot){
//   List<Appointment> appointments = <Appointment>[];
//   appointments.add(
//     Appointment(
//       startTime: snapshot.documents('test')
//     )
//   );
// }
