import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:intl/intl.dart';

import 'package:todoList/util/app_localizations.dart';
import 'package:we_slide/we_slide.dart';
import '../home.dart';
import 'package:todoList/model/Databmanag.dart';

class ActivityTodayShow extends StatefulWidget {
  final QuerySnapshot snapshot;
  final int index;

  const ActivityTodayShow({
    Key key,
    this.snapshot,
    this.index,
  }) : super(key: key);

  @override
  _ActivityTodayShowState createState() => _ActivityTodayShowState();
}

class _ActivityTodayShowState extends State<ActivityTodayShow> {
  TextEditingController nameInputController;
  TextEditingController iconInputController;
  TextEditingController colorInputController;
  TextEditingController _dateController;
  TextEditingController _timeController;
  TextEditingController _ocureIDController;
  TextEditingController _ocurehowController;

  TextEditingController _endtimeController;
  TextEditingController notesInputController;
  String _setTime, _setDate;
  String _hour, _minute, _time;
  String _ehour, _eminute, _etime;
  String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay eselectedTime = TimeOfDay(hour: 00, minute: 00);

  List idalist = [];
  // Map<String, String> idalist = {};
  @override
  void initState() {
    super.initState();
    fetchDataseList();

    iconInputController = new TextEditingController();
    nameInputController = new TextEditingController();
    notesInputController = new TextEditingController();
    iconInputController = new TextEditingController();
    colorInputController = new TextEditingController();
    _dateController = new TextEditingController();
    _timeController = new TextEditingController();
    _ocureIDController = new TextEditingController();
    _ocurehowController = new TextEditingController();

    _endtimeController = new TextEditingController();
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _timeController.text = formatDate(
        DateTime(2021, 03, 16, selectedTime.hour, selectedTime.minute),
        [hh, ':', nn, ' ', am]).toString();

    _endtimeController.text = formatDate(
        DateTime(2021, 03, 16, eselectedTime.hour, eselectedTime.minute),
        [hh, ':', nn, ' ', am]).toString();
  }

  fetchDataseList() async {
    dynamic resultant = await DatabaseManager().getUserlist();
    if (resultant == null) {
      print("unable to retrieve");
    } else {
      setState(() {
        idalist = resultant;
      });
    }
  }

  void dispose() {
    super.dispose();
  }

  bool checkBoxValue = false;
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
    var snapshotOCID = widget.snapshot.docs[widget.index].get("ocureid");
    var snapshotocurHOW = widget.snapshot.docs[widget.index].get("ocurence");

    var snapshotETime = widget.snapshot.docs[widget.index].get('etime');
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
    TextEditingController _ocureIDController =
        TextEditingController(text: snapshotOCID);

    TextEditingController _ocurehowController =
        TextEditingController(text: snapshotocurHOW);

    TextEditingController _endtimeController =
        TextEditingController(text: snapshotETime);
    TextEditingController notesInputController =
        TextEditingController(text: snapshotNotes);

    DateTime today = new DateTime.now();

    var cas = _dateController.text + " " + _endtimeController.text;
    var dateum = DateFormat("dd/MM/yyyy hh:mm a").format(today);
    DateTime formatedDate = DateFormat("dd/MM/yyyy hh:mm a").parse(dateum);
    var selectedDate = DateFormat('dd/MM/yyyy hh:mm a').parse(cas);
    var datum = DateFormat("dd/MM/yyyy").format(today);
    DateTime day = DateFormat("dd/MM/yyyy").parse(datum);
    var selectedDatee = DateFormat('dd/MM/yyyy').parse(_dateController.text);
    final double _panelMinSize = 60.0;
    final double _panelMaxSize = MediaQuery.of(context).size.height / 1.5;

    if (selectedDate.isAfter(formatedDate) &&
        day.isAtSameMomentAs(selectedDatee)) {
      return Slidable(
        actionExtentRatio: 0.2,
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: [
          IconSlideAction(
            icon: Icons.more_horiz,
            color: Colors.blue,
            caption: AppLocalizations.of(context).translate('more'),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      iconInputController.text.toUpperCase(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  body: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Icon(
                                iconsCollection[snapshotIkona],
                                color: colorsMapping[snapshotBarva],
                                size: 60,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshotName.toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Date: ${snapshotDate} ---',
                              style: TextStyle(
                                  fontSize: 17, fontStyle: FontStyle.italic),
                            ),
                            Text(
                              ' Time: ${snapshotTime}',
                              style: TextStyle(
                                  fontSize: 17, fontStyle: FontStyle.italic),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        endIndent: 30,
                        indent: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  snapshotNotes,
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
                ),
              );
            },
          ),
          IconSlideAction(
            icon: Icons.edit,
            color: Colors.green,
            caption: AppLocalizations.of(context).translate('edit'),
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
                        AppLocalizations.of(context).translate('editActivity'),
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
                                maxLength: 20,
                                decoration: InputDecoration(
                                  helperText: AppLocalizations.of(context)
                                      .translate('editANameOfAActivity'),
                                ),
                                controller: nameInputController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: TextField(
                                maxLength: 300,
                                minLines: 1,
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  helperText: AppLocalizations.of(context)
                                      .translate('editNotes'),
                                ),
                                controller: notesInputController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: IconPicker(
                                initialValue: null,
                                icon: Icon(Icons.apps),
                                labelText: AppLocalizations.of(context)
                                    .translate('icon'),
                                title: AppLocalizations.of(context)
                                    .translate('selectAnIcon'),
                                cancelBtn: AppLocalizations.of(context)
                                    .translate('cancel'),
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
                              AppLocalizations.of(context)
                                  .translate('chooseDate'),
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
                                  onSaved: (String val) {},
                                  enabled: false,
                                  controller: _dateController,
                                  decoration: InputDecoration(
                                      disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                            Text(AppLocalizations.of(context)
                                .translate('chooseTime')),
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
                                  onSaved: (String val) {},
                                  enabled: false,
                                  keyboardType: TextInputType.datetime,
                                  controller: _timeController,
                                  decoration: InputDecoration(
                                      disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                            Text(AppLocalizations.of(context)
                                .translate('chooseEndTime')),
                            InkWell(
                              onTap: () async {
                                final TimeOfDay picked = await showTimePicker(
                                  context: context,
                                  initialTime: eselectedTime,
                                );
                                if (picked != null) {
                                  setState(() {
                                    eselectedTime = picked;
                                    _ehour = eselectedTime.hour.toString();
                                    _eminute = eselectedTime.minute.toString();
                                    _etime = _ehour + ':' + _eminute;
                                    _endtimeController.text = _etime;
                                    _endtimeController.text = formatDate(
                                        DateTime(
                                            2021,
                                            03,
                                            16,
                                            eselectedTime.hour,
                                            eselectedTime.minute),
                                        [hh, ':', nn, ' ', am]).toString();
                                  });
                                }
                              },
                              child: Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 25),
                                  textAlign: TextAlign.center,
                                  onSaved: (String val) {},
                                  enabled: false,
                                  keyboardType: TextInputType.datetime,
                                  controller: _endtimeController,
                                  decoration: InputDecoration(
                                      disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                            Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 70, left: 30, right: 30),
                                child: new CheckboxListTile(
                                  title: Text("Change ocuring activities"),
                                  value: checkBoxValue,
                                  activeColor: Colors.green,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      checkBoxValue = newValue;
                                      _ocurehowController.text =
                                          checkBoxValue.toString();
                                    });
                                  },
                                ),
                              )
                            ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('save'),
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    onPressed: () {
                                      if (nameInputController.text.isNotEmpty &&
                                          _dateController.text.isNotEmpty &&
                                          _timeController.text.isNotEmpty &&
                                          _endtimeController.text.isNotEmpty) {
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
                                          'etime': _endtimeController.text,
                                          "ocureid": _ocureIDController.text,
                                          "ocurence": _ocurehowController.text,
                                          'notes': notesInputController.text,
                                          'timestamp': today,
                                        });
                                        if (_ocureIDController.text == "") {
                                          Navigator.pop(context);
                                        } else {
                                          for (var i = 0;
                                              i < idalist.length / 3;
                                              i++) {
                                            if (_ocureIDController.text ==
                                                idalist[i * 3]) {
                                              var doccid = idalist[(i * 3) + 1];
                                              var dateocurid =
                                                  idalist[(i * 3) + 2];
                                              DateTime datedocid =
                                                  DateFormat("dd/MM/yyyy")
                                                      .parse(dateocurid);
                                              print(datedocid);
                                              DateTime datefcontroler =
                                                  DateFormat("dd/MM/yyyy")
                                                      .parse(
                                                          _dateController.text);

                                              var difer = datedocid
                                                  .difference(datefcontroler)
                                                  .inDays;
                                              var difcount;
                                              if (difer < 0) {
                                                difcount = difer;
                                              } else {
                                                difcount = 7 - difer;
                                              }

                                              DateTime savedate = new DateTime(
                                                  datedocid.year,
                                                  datedocid.month,
                                                  datedocid.day + difcount);

                                              var savdat =
                                                  DateFormat("dd/MM/yyyy")
                                                      .format(savedate);

                                              if (doccid != docID) {
                                                if (difer == 7) {
                                                  FirebaseFirestore.instance
                                                      .collection('userData')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser.uid)
                                                      .collection('activity')
                                                      .doc(doccid)
                                                      .update({
                                                    'displayName': FirebaseAuth
                                                        .instance
                                                        .currentUser
                                                        .displayName,
                                                    'uid': FirebaseAuth.instance
                                                        .currentUser.uid,
                                                    'name': nameInputController
                                                        .text,
                                                    'ikona': iconInputController
                                                        .text,
                                                    'barva':
                                                        colorInputController
                                                            .text,
                                                    'time':
                                                        _timeController.text,
                                                    'etime':
                                                        _endtimeController.text,
                                                    "ocureid":
                                                        _ocureIDController.text,
                                                    "ocurence":
                                                        _ocurehowController
                                                            .text,
                                                    'notes':
                                                        notesInputController
                                                            .text,
                                                    'timestamp': today,
                                                  });
                                                } else {
                                                  _dateController.text = savdat;
                                                  FirebaseFirestore.instance
                                                      .collection('userData')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser.uid)
                                                      .collection('activity')
                                                      .doc(doccid)
                                                      .update({
                                                    'displayName': FirebaseAuth
                                                        .instance
                                                        .currentUser
                                                        .displayName,
                                                    'uid': FirebaseAuth.instance
                                                        .currentUser.uid,
                                                    'name': nameInputController
                                                        .text,
                                                    'ikona': iconInputController
                                                        .text,
                                                    'date':
                                                        _dateController.text,
                                                    'barva':
                                                        colorInputController
                                                            .text,
                                                    'time':
                                                        _timeController.text,
                                                    'etime':
                                                        _endtimeController.text,
                                                    "ocureid":
                                                        _ocureIDController.text,
                                                    "ocurence":
                                                        _ocurehowController
                                                            .text,
                                                    'notes':
                                                        notesInputController
                                                            .text,
                                                    'timestamp': today,
                                                  });
                                                }
                                              }
                                            }
                                          }
                                          Navigator.pop(context);
                                        }
                                      }
                                    }),
                                TextButton(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('cancel'),
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  onPressed: () {
                                    if (nameInputController.text.isNotEmpty &&
                                        iconInputController.text.isNotEmpty &&
                                        _dateController.text.isNotEmpty &&
                                        _timeController.text.isNotEmpty &&
                                        _endtimeController.text.isNotEmpty &&
                                        colorInputController.text.isNotEmpty) {
                                      return showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        'doYouReallyWantExit'),
                                              ),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: [
                                                    Text(AppLocalizations.of(
                                                            context)
                                                        .translate(
                                                            'youMakeSomeChangesDoYouReallyWantToExit'))
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate('yes'),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (builder) =>
                                                                HomeScreen()));
                                                  },
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate('no'),
                                                  ),
                                                )
                                              ],
                                            );
                                          });
                                    }
                                    nameInputController.clear();
                                    iconInputController.clear();
                                    _dateController.clear();
                                    _timeController.clear();
                                    _endtimeController.clear();
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
            caption: AppLocalizations.of(context).translate('delete'),
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
          shape: ContinuousRectangleBorder(),
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
