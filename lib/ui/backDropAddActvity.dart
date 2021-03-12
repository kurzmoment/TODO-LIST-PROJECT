import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:intl/intl.dart';

class AddActForms extends StatefulWidget {
  @override
  _AddActFormsState createState() => _AddActFormsState();
}

class _AddActFormsState extends State<AddActForms> {
  TextEditingController nameInputController;
  TextEditingController iconInputController;
  TextEditingController colorInputController;
  TextEditingController dateInputController;
  TextEditingController timeInputController;

  void initState() {
    super.initState();
    iconInputController = new TextEditingController();
    nameInputController = new TextEditingController();
    iconInputController = new TextEditingController();
    colorInputController = new TextEditingController();
    dateInputController = new TextEditingController();
    timeInputController = new TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          child: TextField(
            decoration: InputDecoration(
              helperText: 'Enter a name of a activity',
            ),
            controller: nameInputController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          child: TextField(
            decoration: InputDecoration(
              helperText: 'Enter a name date',
            ),
            controller: dateInputController,
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
            // onChanged: (String name) {
            //   for (name in iconsCollection.keys) {
            //     if (name == 'shopping') {
            //       iconInputController.text = name;
            //     } else if (name == 'gym') {
            //       iconInputController.text = name;
            //     } else if (name == 'business') {
            //       iconInputController.text = name;
            //     } else if (name == 'eat') {
            //       iconInputController.text = name;
            //     } else if (name == 'code') {
            //       iconInputController.text = name;
            //     } else if (name == 'repair') {
            //       iconInputController.text = name;
            //     } else {
            //       iconInputController.text = 'default';
            //     }
            //   }
            // },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: ColorPicker(
            color: screenPickerColor,
            onColorChanged: (Color color) => {
              setState(() => screenPickerColor = color),
            },
            heading: Text(
              'Select color for your activity',
              style: Theme.of(context).textTheme.headline5,
            ),
            subheading: Text(
              'Select shade of that colour',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child:
              //SfDateRangePicker(
              //   controller: dateInputController,
              // ),
              DateTimePicker(
            initialSelectedDate: dt.add(Duration(days: 1)),
            startDate: dt,
            endDate: dt.add(Duration(days: 60)),
            startTime: DateTime(dt.year, dt.month, dt.day, 6),
            endTime: DateTime(dt.year, dt.month, dt.day, 18),
            timeInterval: Duration(minutes: 15),
            is24h: false,
            datePickerTitle: 'Pick your preferred date',
            timePickerTitle: 'Pick your preferred time',
            timeOutOfRangeError: 'Sorry shop is closed now',
            onDateChanged: (date) {
              setState(() {
                _d1 = DateFormat('dd MMM, yyyy').format(date);
              });
            },
            onTimeChanged: (time) {
              setState(() {
                _t1 = DateFormat('hh:mm:ss aa').format(time);
              });
            },
          ),
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
                    'ikona': iconInputController.text,
                    'title': dateInputController.text,
                    'timestamp': dt,
                  }).then((response) {
                    print(response.documentID);
                    Navigator.pop(context);
                    nameInputController.clear();
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
                nameInputController.clear();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
