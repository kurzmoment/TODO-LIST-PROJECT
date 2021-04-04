import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:intl/intl.dart';
import 'package:we_slide/we_slide.dart';

import '../home.dart';

class ActivityDoneShow extends StatefulWidget {
  final QuerySnapshot snapshot;
  final int index;

  const ActivityDoneShow({Key key, this.snapshot, this.index})
      : super(key: key);

  @override
  _ActivityDoneState createState() => _ActivityDoneState();
}

class _ActivityDoneState extends State<ActivityDoneShow> {
  TextEditingController nameInputController;
  TextEditingController iconInputController;
  TextEditingController colorInputController;
  TextEditingController _dateController;
  TextEditingController _timeController;
  TextEditingController notesInputController;
  String _setTime, _setDate;
  String _hour, _minute, _time;
  String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  @override
  void initState() {
    super.initState();
    iconInputController = new TextEditingController();
    nameInputController = new TextEditingController();
    notesInputController = new TextEditingController();
    iconInputController = new TextEditingController();
    colorInputController = new TextEditingController();
    _dateController = new TextEditingController();
    _timeController = new TextEditingController();
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _timeController.text = formatDate(
        DateTime(2021, 03, 16, selectedTime.hour, selectedTime.minute),
        [hh, ':', nn, ' ', am]).toString();
  }

  void dispose() {
    super.dispose();
  }

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
    var snapshotName = widget.snapshot.docs[widget.index].get('name');
    var snapshotIkona = widget.snapshot.docs[widget.index].get('ikona');
    var snapshotBarva = widget.snapshot.docs[widget.index].get('barva');
    var snapshotDate = widget.snapshot.docs[widget.index].get('date');
    var snapshotTime = widget.snapshot.docs[widget.index].get('time');
    var snapshotNotes = widget.snapshot.docs[widget.index].get('notes');
    var docID = widget.snapshot.docs[widget.index].id;
    TextEditingController nameInputController =
        TextEditingController(text: snapshotName);
    TextEditingController iconInputController =
        TextEditingController(text: snapshotIkona);
    TextEditingController colorInputController =
        TextEditingController(text: snapshotBarva);
    TextEditingController _dateController =
        TextEditingController(text: snapshotDate);
    TextEditingController _timeController =
        TextEditingController(text: snapshotTime);
    TextEditingController notesInputController =
        TextEditingController(text: snapshotNotes);

    DateTime today = new DateTime.now();
    DateTime formatedDate = today.subtract(Duration(
        hours: today.hour,
        minutes: today.minute,
        seconds: today.second,
        milliseconds: today.millisecond,
        microseconds: today.microsecond));
    var selectedDate = DateFormat('dd/MM/yyyy').parse(_dateController.text);
    final double _panelMinSize = 60.0;
    final double _panelMaxSize = MediaQuery.of(context).size.height / 1.5;
    var _initIcon = FaIcon(FontAwesomeIcons.circle);
    if (selectedDate.isBefore(formatedDate)) {
      return Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: [
          IconSlideAction(
            icon: Icons.delete,
            color: Colors.red,
            caption: 'Delete',
            onTap: () async {
              var collectionReference =
                  FirebaseFirestore.instance.collection("userData");
              await collectionReference
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('activity')
                  .doc(docID)
                  .delete()
                  .catchError((error) => print("$error"));
            },
          )
        ],
        child: Card(
          shadowColor: Colors.black,
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                iconsCollection[snapshotIkona],
                color: colorsMapping[snapshotBarva],
              ),
            ),
            title: Text(
              snapshotName,
              style: TextStyle(fontSize: 20),
            ),
            trailing: IconButton(
              icon: _initIcon,
              onPressed: () async {
                _initIcon = FaIcon(FontAwesomeIcons.solidCircle);
                var collectionReference =
                    FirebaseFirestore.instance.collection("userData");
                await collectionReference
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .collection('activity')
                    .doc(docID)
                    .delete()
                    .catchError((error) => print("$error"));
              },
            ),
            subtitle: Text('${snapshotDate}, ${snapshotTime}'),
          ),
        ),
      );
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }
}

Widget colorSwitch(
    Color color, String colorController, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color,
      ),
      width: 35,
      height: 35,
      child: TextButton(
        onPressed: () {
          controller.text = colorController;
        },
        child: Text(''),
      ),
    ),
  );
}
