import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:intl/intl.dart';
import 'package:todoList/home.dart';
import 'package:date_format/date_format.dart';
import 'package:todoList/util/app_localizations.dart';
import 'package:todoList/util/userSetup.dart';

class AddActForms extends StatefulWidget {
  @override
  _AddActFormsState createState() => _AddActFormsState();
}

class _AddActFormsState extends State<AddActForms> {
  String _setTime, _setDate;
  String _hour, _minute, _time;
  String _ehour, _eminute, _etime;
  String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay eselectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _dateController;
  TextEditingController _timeController;
  TextEditingController _ocureID;
  TextEditingController _endtimeController;
  Future<Null> _selectedDate(BuildContext context) async {
    var selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2021),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  Future<Null> _selectedTime(BuildContext context) async {
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
            DateTime(2021, 03, 16, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, ' ', am]).toString();
      });
    }
  }

  Future<Null> _eselectedTime(BuildContext context) async {
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
            DateTime(2021, 03, 16, eselectedTime.hour, selectedTime.minute),
            [hh, ':', nn, ' ', am]).toString();
      });
    }
  }

  // DATE AND TIME PICK
  TextEditingController _nameController;
  TextEditingController _notesController;
  TextEditingController _iconController;
  TextEditingController _colorController;

  void initState() {
    super.initState();
    _iconController = new TextEditingController();
    _nameController = new TextEditingController();

    _ocureID = new TextEditingController();
    _notesController = new TextEditingController();
    _iconController = new TextEditingController();
    _colorController = new TextEditingController();
    _dateController = new TextEditingController();
    _timeController = new TextEditingController();
    _endtimeController = new TextEditingController();
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _timeController.text = formatDate(
        DateTime(2021, 03, 16, selectedTime.hour, selectedTime.minute),
        [hh, ':', nn, ' ', am]).toString();
    _endtimeController.text = formatDate(
        DateTime(2021, 03, 16, eselectedTime.hour, eselectedTime.minute),
        [hh, ':', nn, ' ', am]).toString();
  }

  String initalValue = 'icon';
  DateTime dt = new DateTime.now();
  Color screenPickerColor = Colors.black;

  final Map<String, IconData> iconsCollection = {
    'shopping': FontAwesomeIcons.shoppingCart,
    'gym': FontAwesomeIcons.dumbbell,
    'business': FontAwesomeIcons.briefcase,
    'eat': FontAwesomeIcons.utensils,
    'code': FontAwesomeIcons.code,
    'repair': FontAwesomeIcons.tools,
    'default': FontAwesomeIcons.question
  };

  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
            child: TextField(
              maxLength: 20,
              decoration: InputDecoration(
                helperText: AppLocalizations.of(context)
                    .translate('enterANameOfAActivity'),
              ),
              controller: _nameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: TextField(
              maxLength: 300,
              minLines: 1,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                helperText:
                    AppLocalizations.of(context).translate('enterNotes'),
              ),
              controller: _notesController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: IconPicker(
              initialValue: null,
              icon: Icon(Icons.apps),
              labelText: AppLocalizations.of(context).translate('icon'),
              title: AppLocalizations.of(context).translate('selectAnIcon'),
              cancelBtn: AppLocalizations.of(context).translate('cancel'),
              enableSearch: false,
              iconCollection: iconsCollection,
              controller: _iconController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  colorSwitch(Colors.red, 'red', _colorController),
                  colorSwitch(Colors.blue, 'blue', _colorController),
                  colorSwitch(Colors.green, 'green', _colorController),
                  colorSwitch(Colors.pink, 'pink', _colorController),
                  colorSwitch(Colors.yellow, 'yellow', _colorController),
                  colorSwitch(Colors.lightBlue, 'lightBlue', _colorController),
                  colorSwitch(
                      Colors.lightGreen, 'lightGreen', _colorController),
                  colorSwitch(Colors.purple, 'purple', _colorController),
                  colorSwitch(
                      Colors.amberAccent, 'amberAccent', _colorController),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Text(
                AppLocalizations.of(context).translate('chooseDate'),
              ),
              InkWell(
                onTap: () {
                  _selectedDate(context);
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
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ),
              Text(
                AppLocalizations.of(context).translate('chooseTime'),
              ),
              InkWell(
                onTap: () {
                  _selectedTime(context);
                },
                child: Container(
                  child: TextFormField(
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                    onSaved: (String val) {
                      _setTime = val;
                    },
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _timeController,
                    decoration: InputDecoration(
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ),
              Text(
                AppLocalizations.of(context).translate('chooseEndTime'),
              ),
              InkWell(
                onTap: () {
                  _eselectedTime(context);
                },
                child: Container(
                  child: TextFormField(
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                    onSaved: (String val) {
                      _setTime = val;
                    },
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _endtimeController,
                    decoration: InputDecoration(
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              )
            ],
          ),
          Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
              child: new CheckboxListTile(
                  title: Text("Repeat"),
                  value: checkBoxValue,
                  activeColor: Colors.green,
                  onChanged: (bool newValue) {
                    setState(() {
                      checkBoxValue = newValue;
                    });
                  }),
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  child: Text(
                    AppLocalizations.of(context).translate('save'),
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        checkBoxValue == true) {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      var userName = auth.currentUser.displayName;
                      String uid = auth.currentUser.uid.toString();
                      _ocureID.text = FirebaseFirestore.instance
                          .collection('userData')
                          .doc(uid)
                          .collection('activity')
                          .doc()
                          .id;
                      addActivityUID(
                          _nameController,
                          _iconController,
                          _dateController,
                          _colorController,
                          _timeController,
                          _endtimeController,
                          _notesController,
                          _ocureID,
                          dt,
                          userName);

                      for (var i = 0; i < 2; i++) {
                        var datum = _dateController.text;
                        var dateFormat = DateFormat("dd/MM/yyyy");
                        DateTime tydenplus = dateFormat.parse(datum);
                        DateTime dateTime = new DateTime(
                            tydenplus.year, tydenplus.month, tydenplus.day + 7);

                        _dateController.text = dateFormat.format(dateTime);

                        addActivityUID(
                            _nameController,
                            _iconController,
                            _dateController,
                            _colorController,
                            _timeController,
                            _endtimeController,
                            _notesController,
                            _ocureID,
                            dt,
                            userName);
                      }
                      Navigator.pop(context);
                      _nameController.clear();
                      _iconController.clear();
                      _timeController.clear();
                      _dateController.clear();
                      _ocureID.clear();
                      _endtimeController.clear();
                      _colorController.clear();
                      _notesController.clear();
                    } else if (_nameController.text.isNotEmpty) {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      var userName = auth.currentUser.displayName;

                      addActivityUID(
                              _nameController,
                              _iconController,
                              _dateController,
                              _colorController,
                              _timeController,
                              _endtimeController,
                              _notesController,
                              _ocureID,
                              dt,
                              userName)
                          .then((response) {
                        Navigator.pop(context);
                        _nameController.clear();
                        _iconController.clear();
                        _timeController.clear();
                        _dateController.clear();
                        _ocureID.clear();
                        _endtimeController.clear();
                        _colorController.clear();
                        _notesController.clear();
                      }).catchError((error) => print(error));
                    }
                  }),
              TextButton(
                child: Text(
                  AppLocalizations.of(context).translate('cancel'),
                  style: TextStyle(fontSize: 25),
                ),
                onPressed: () {
                  if (_nameController.text.isNotEmpty ||
                      _iconController.text.isNotEmpty ||
                      _dateController.text.isNotEmpty ||
                      _timeController.text.isNotEmpty ||
                      _endtimeController.text.isNotEmpty ||
                      _colorController.text.isNotEmpty ||
                      _notesController.text.isNotEmpty) {
                    return showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(AppLocalizations.of(context)
                              .translate('doYouReallyWantExit')),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Text(AppLocalizations.of(context).translate(
                                    'youMakeSomeChangesDoYouReallyWantToExit'))
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                                child: Text(AppLocalizations.of(context)
                                    .translate('yes')),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (builder) => HomeScreen()));
                                }),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                  AppLocalizations.of(context).translate('no')),
                            )
                          ],
                        );
                      },
                    );
                  }
                  _nameController.clear();
                  _iconController.clear();
                  _dateController.clear();
                  _timeController.clear();
                  _endtimeController.clear();
                  _colorController.clear();
                  _notesController.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
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
