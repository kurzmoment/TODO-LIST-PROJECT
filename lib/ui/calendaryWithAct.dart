import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todoList/home.dart';
import 'package:todoList/ui/addBackdrop.dart';
import 'package:todoList/ui/profilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoList/util/app_localizations.dart';

class ListOfActivities extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;

  ListOfActivities({Key key, this.snapshot, this.index}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate('listOfActivities'),
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
    var snapshotNotes = snapshot.docs[index].get('notes');
    var snapshotBarva = snapshot.docs[index].get('barva');
    var snapshotDate = snapshot.docs[index].get('date');
    var snapshotTime = snapshot.docs[index].get('time');
    var snapshotETime = snapshot.docs[index].get('etime');
    var snapshotIkona = snapshot.docs[index].get('ikona');
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
        notes: snapshotNotes,
        location: snapshotIkona));
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
          allowedViews: [CalendarView.timelineMonth, CalendarView.schedule],
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
          onTap: (CalendarTapDetails calendarTapDetails) {
            if (calendarTapDetails.targetElement ==
                CalendarElement.appointment) {
              Appointment appointment = calendarTapDetails.appointments[0];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SecondRoute(
                    appointment: appointment,
                    snapshot: snapshot.data,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}

class SecondRoute extends StatelessWidget {
  final Appointment appointment;
  final QuerySnapshot snapshot;
  SecondRoute({this.appointment, this.snapshot});

  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> iconsCollection = {
      'shopping': FontAwesomeIcons.shoppingCart,
      'gym': FontAwesomeIcons.dumbbell,
      'business': FontAwesomeIcons.briefcase,
      'eat': FontAwesomeIcons.utensils,
      'code': FontAwesomeIcons.code,
      'repair': FontAwesomeIcons.tools,
    };
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appointment.color,
        centerTitle: true,
        title: Text(
          "Detail of Activity",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Icon(
              iconsCollection[appointment.location],
              color: appointment.color,
              size: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                appointment.subject.toUpperCase(),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Od : ',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                DateFormat('dd/MM/yyyy')
                    .format(
                      appointment.startTime,
                    )
                    .toString(),
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '  Cas : ',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                DateFormat('hh:mm a')
                    .format(
                      appointment.startTime,
                    )
                    .toString(),
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            endIndent: 30,
            indent: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Do : ',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                DateFormat('dd/MM/yyyy')
                    .format(
                      appointment.endTime,
                    )
                    .toString(),
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '  Cas : ',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                DateFormat('hh:mm a')
                    .format(
                      appointment.endTime,
                    )
                    .toString(),
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            endIndent: 30,
            indent: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    scrollDirection: Axis.vertical,
                    child: Text(
                      appointment.notes,
                      style: TextStyle(fontSize: 19),
                      textAlign: TextAlign.start,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
