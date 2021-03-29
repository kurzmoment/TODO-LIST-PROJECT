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
  TextEditingController categoryInputController;
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
    categoryInputController = new TextEditingController();
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
    var snapshotCategory = widget.snapshot.docs[widget.index].get('category');
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
    TextEditingController _categoryController =
        TextEditingController(text: snapshotCategory);

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
    if (selectedDate.isBefore(formatedDate)) {
      return Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: [
          IconSlideAction(
            icon: Icons.edit,
            color: Colors.green,
            caption: 'Edit',
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => Scaffold(
                  body: WeSlide(
                    controller: WeSlideController(),
                    blurSigma: 0.75,
                    blur: true,
                    panelMaxSize: _panelMaxSize,
                    panelMinSize: _panelMinSize,
                    overlayOpacity: 10,
                    panelBorderRadiusBegin: 0,
                    panelBorderRadiusEnd: 25,
                    body: Home(),
                    panelHeader: Container(
                      alignment: Alignment.center,
                      color: Colors.blue,
                      height: _panelMinSize,
                      child: Text(
                        'Edit activity',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    panel: Scaffold(
                      body: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              child: TextField(
                                decoration: InputDecoration(
                                  helperText: 'Edit a name of a activity',
                                ),
                                controller: nameInputController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: TextField(
                                decoration: InputDecoration(
                                  helperText: 'Edit notes',
                                ),
                                controller: notesInputController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: TextField(
                                decoration: InputDecoration(
                                  helperText: 'Edit category',
                                ),
                                controller: _categoryController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: IconPicker(
                                initialValue: null,
                                icon: Icon(Icons.apps),
                                labelText: "Icon",
                                title: "Select an icon",
                                cancelBtn: 'Cancel',
                                enableSearch: false,
                                iconCollection: iconsCollection,
                                controller: iconInputController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Container(
                                height: 50,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    colorSwitch(Colors.red, 'red',
                                        colorInputController),
                                    colorSwitch(Colors.blue, 'blue',
                                        colorInputController),
                                    colorSwitch(Colors.green, 'green',
                                        colorInputController),
                                    colorSwitch(Colors.pink, 'pink',
                                        colorInputController),
                                    colorSwitch(Colors.yellow, 'yellow',
                                        colorInputController),
                                    colorSwitch(Colors.lightBlue, 'lightBlue',
                                        colorInputController),
                                    colorSwitch(Colors.lightGreen, 'lightGreen',
                                        colorInputController),
                                    colorSwitch(Colors.purple, 'purple',
                                        colorInputController),
                                    colorSwitch(Colors.amberAccent,
                                        'amberAccent', colorInputController),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              'Choose date',
                            ),
                            InkWell(
                              onTap: () async {
                                var selectedDate = DateFormat('dd/MM/yyyy')
                                    .parse(_dateController.text);
                                print(selectedDate);
                                final DateTime picked = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    initialDatePickerMode: DatePickerMode.day,
                                    firstDate: DateTime(2021),
                                    lastDate: DateTime(2101));
                                if (picked != null) {
                                  setState(() {
                                    selectedDate = picked;
                                    _dateController.text =
                                        DateFormat('dd/MM/yyyy')
                                            .format(selectedDate);
                                  });
                                }
                              },
                              child: Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 25),
                                  textAlign: TextAlign.center,
                                  onSaved: (String val) {
                                    _setDate = val;
                                  },
                                  enabled: false,
                                  controller: _dateController,
                                  decoration: InputDecoration(
                                      disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                            Text(
                              'Choose time',
                            ),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay picked = await showTimePicker(
                                  context: context,
                                  initialTime: selectedTime,
                                );
                                if (picked != null) {
                                  setState(() {
                                    selectedTime = picked;
                                    _hour = selectedTime.hour.toString();
                                    _minute = selectedTime.minute.toString();
                                    _time = _hour + ':' + _minute;
                                    _timeController.text = _time;
                                    _timeController.text = formatDate(
                                        DateTime(
                                            2021,
                                            03,
                                            16,
                                            selectedTime.hour,
                                            selectedTime.minute),
                                        [hh, ':', nn, ' ', am]).toString();
                                  });
                                }
                              },
                              child: Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 25),
                                  textAlign: TextAlign.center,
                                  onSaved: (String val) {
                                    _setTime = val;
                                  },
                                  enabled: false,
                                  keyboardType: TextInputType.datetime,
                                  controller: _timeController,
                                  decoration: InputDecoration(
                                      disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  child: Text(
                                    'Save',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  onPressed: () {
                                    if (nameInputController.text.isNotEmpty &&
                                        iconInputController.text.isNotEmpty &&
                                        _dateController.text.isNotEmpty &&
                                        colorInputController.text.isNotEmpty &&
                                        _timeController.text.isNotEmpty) {
                                      FirebaseFirestore.instance
                                          .collection('userData')
                                          .doc(FirebaseAuth
                                              .instance.currentUser.uid)
                                          .collection('activity')
                                          .doc(docID)
                                          .update({
                                        'displayName': FirebaseAuth
                                            .instance.currentUser.displayName,
                                        'uid': FirebaseAuth
                                            .instance.currentUser.uid,
                                        'name': nameInputController.text,
                                        'ikona': iconInputController.text,
                                        'date': _dateController.text,
                                        'barva': colorInputController.text,
                                        'time': _timeController.text,
                                        'notes': notesInputController.text,
                                        'timestamp': today,
                                      }).then((response) {
                                        Navigator.pop(context);
                                      });
                                    }
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  onPressed: () {
                                    if (nameInputController.text.isNotEmpty &&
                                        iconInputController.text.isNotEmpty &&
                                        _dateController.text.isNotEmpty &&
                                        _timeController.text.isNotEmpty &&
                                        colorInputController.text.isNotEmpty) {
                                      return showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Do you really want exit?'),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: [
                                                    Text(
                                                        'You make some changes do you really want to exit?')
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text('Yes'),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Home()));
                                                  },
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('No'),
                                                )
                                              ],
                                            );
                                          });
                                    }
                                    nameInputController.clear();
                                    iconInputController.clear();
                                    _dateController.clear();
                                    _timeController.clear();
                                    colorInputController.clear();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
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
