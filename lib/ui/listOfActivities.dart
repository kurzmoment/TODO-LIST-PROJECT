import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todoList/home.dart';

import '../hexcolor.dart';
import 'activities.dart';

class ListOfActivities extends StatefulWidget {
  @override
  _ListOfActivitiesState createState() => _ListOfActivitiesState();
}

class _ListOfActivitiesState extends State<ListOfActivities> {
  final colorBottom = HexColor('FCEDC5');
  final colorActivity = HexColor('FF0000');
  final colorBody = HexColor('EEFCFA');
  final colorTop = HexColor('A1E7F7');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTop,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'List of activities',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SfCalendar(
        view: CalendarView.workWeek,
        timeSlotViewSettings: TimeSlotViewSettings(
          startHour: 6,
          endHour: 22,
          nonWorkingDays: <int>[DateTime.sunday],
        ),
      ),
      //Activity(),
      bottomNavigationBar: new BottomAppBar(
        color: colorBottom,
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
              onPressed: () => debugPrint('Account'),
            ),
            IconButton(
              icon: Icon(Icons.calendar_today_rounded),
              onPressed: () {
                // do nothing
              },
            ),
          ],
        ),
      ),
    );
  }
}
