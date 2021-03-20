import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:intl/intl.dart';
import 'package:todoList/home.dart';
import 'package:date_format/date_format.dart';

class AddActForms extends StatefulWidget {
  @override
  _AddActFormsState createState() => _AddActFormsState();
}

class _AddActFormsState extends State<AddActForms> {
  // DATE AND TIME PICK
  String _setTime, _setDate;
  String _hour, _minute, _time;
  String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

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

  // DATE AND TIME PICK
  TextEditingController nameInputController;
  TextEditingController notesInputController;
  TextEditingController categoryInputController;
  TextEditingController iconInputController;
  TextEditingController colorInputController;

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

  String initalValue = 'icon';
  var _d1;
  var _t1;
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
  String dropDownValue = 'NONE';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
            child: TextField(
              decoration: InputDecoration(
                helperText: 'Enter a name of a activity',
              ),
              controller: nameInputController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: TextField(
              decoration: InputDecoration(
                helperText: 'Enter notes',
              ),
              controller: notesInputController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: DropdownButton<String>(
              value: dropDownValue,
              icon: Icon(Icons.arrow_drop_down_outlined),
              iconSize: 25,
              elevation: 15,
              style: TextStyle(color: Colors.black),
              onChanged: (String newValue) {
                setState(() {
                  dropDownValue = newValue;
                  categoryInputController.text = dropDownValue;
                });
              },
              items: <String>['GYM', 'WORK', 'NONE']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  colorSwitch(Colors.red, 'red', colorInputController),
                  colorSwitch(Colors.black, 'black', colorInputController),
                  colorSwitch(Colors.blue, 'blue', colorInputController),
                  colorSwitch(Colors.green, 'green', colorInputController),
                  colorSwitch(Colors.pink, 'pink', colorInputController),
                  colorSwitch(Colors.yellow, 'yellow', colorInputController),
                  colorSwitch(
                      Colors.lightBlue, 'lightBlue', colorInputController),
                  colorSwitch(
                      Colors.lightGreen, 'lightGreen', colorInputController),
                  colorSwitch(Colors.purple, 'purple', colorInputController),
                  colorSwitch(
                      Colors.amberAccent, 'amberAccent', colorInputController),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Text(
                'Choose date',
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
                'Choose time',
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
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 25),
                ),
                onPressed: () {
                  if (nameInputController.text.isNotEmpty) {
                    Firestore.instance.collection('test').add({
                      'name': nameInputController.text,
                      'category': categoryInputController.text,
                      'ikona': iconInputController.text,
                      'date': _dateController.text,
                      'barva': colorInputController.text,
                      'time': _timeController.text,
                      'timestamp': dt,
                      'notes': notesInputController.text,
                    }).then((response) {
                      print(response.documentID);
                      Navigator.pop(context);
                      nameInputController.clear();
                      categoryInputController.clear();
                      iconInputController.clear();
                      _dateController.clear();
                      _timeController.clear();
                      colorInputController.clear();
                      notesInputController.clear();
                    }).catchError((error) => print(error));
                  }
                },
              ),
              FlatButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 25),
                ),
                onPressed: () {
                  if (nameInputController.text.isNotEmpty ||
                      iconInputController.text.isNotEmpty ||
                      categoryInputController.text.isNotEmpty ||
                      _dateController.text.isNotEmpty ||
                      _timeController.text.isNotEmpty ||
                      colorInputController.text.isNotEmpty ||
                      notesInputController.text.isNotEmpty) {
                    return showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Do you really want exit?'),
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (builder) => HomeScreen()));
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
                  categoryInputController.clear();
                  iconInputController.clear();
                  _dateController.clear();
                  _timeController.clear();
                  colorInputController.clear();
                  notesInputController.clear();
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
