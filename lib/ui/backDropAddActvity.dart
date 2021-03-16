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
  final Map<String, Color> colorsColection = {
    'red': Colors.red,
    'black': Colors.black,
    'blue': Colors.blue,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'pink': Colors.pink,
  };
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                colorSwitch(Colors.red, getColor('red', colorInputController)),
                colorSwitch(
                    Colors.black, getColor('black', colorInputController)),
                colorSwitch(
                    Colors.blue, getColor('blue', colorInputController)),
                colorSwitch(
                    Colors.green, getColor('green', colorInputController)),
                colorSwitch(
                    Colors.pink, getColor('pink', colorInputController)),
                colorSwitch(
                    Colors.yellow, getColor('yellow', colorInputController)),
                colorSwitch(Colors.lightBlue,
                    getColor('lightBlue', colorInputController)),
                colorSwitch(Colors.lightGreen,
                    getColor('lightGreen', colorInputController)),
                colorSwitch(
                    Colors.purple, getColor('purple', colorInputController)),
                colorSwitch(Colors.amberAccent,
                    getColor('amberAccent', colorInputController)),
              ],
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        //   child: Row(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(6.0),
        //         child: Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(25),
        //             color: Colors.red,
        //           ),
        //           width: 35,
        //           height: 35,
        //           child: TextButton(
        //             onPressed: () {
        //               colorInputController.text = 'red';
        //             },
        //             child: Text(''),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(6.0),
        //         child: Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(25),
        //             color: Colors.black,
        //           ),
        //           width: 35,
        //           height: 35,
        //           child: TextButton(
        //             onPressed: () {
        //               colorInputController.text = 'black';
        //             },
        //             child: Text(''),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(6.0),
        //         child: Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(25),
        //             color: Colors.blue,
        //           ),
        //           width: 35,
        //           height: 35,
        //           child: TextButton(
        //             onPressed: () {
        //               colorInputController.text = 'blue';
        //             },
        //             child: Text(''),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(6.0),
        //         child: Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(25),
        //             color: Colors.green,
        //           ),
        //           width: 35,
        //           height: 35,
        //           child: TextButton(
        //             onPressed: () {
        //               colorInputController.text = 'green';
        //             },
        //             child: Text(''),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(6.0),
        //         child: Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(25),
        //             color: Colors.pink,
        //           ),
        //           width: 35,
        //           height: 35,
        //           child: TextButton(
        //             onPressed: () {
        //               colorInputController.text = 'pink';
        //             },
        //             child: Text(''),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(6.0),
        //         child: Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(25),
        //             color: Colors.yellow,
        //           ),
        //           width: 35,
        //           height: 35,
        //           child: TextButton(
        //             onPressed: () {
        //               colorInputController.text = 'yellow';
        //             },
        //             child: Text(''),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        //   child: DateTimePicker(
        //     initialSelectedDate: dt.add(Duration(days: 1)),
        //     startDate: dt,
        //     endDate: dt.add(Duration(days: 60)),
        //     startTime: DateTime(dt.year, dt.month, dt.day, 6),
        //     endTime: DateTime(dt.year, dt.month, dt.day, 18),
        //     timeInterval: Duration(minutes: 15),
        //     is24h: false,
        //     datePickerTitle: 'Pick your preferred date',
        //     timePickerTitle: 'Pick your preferred time',
        //     timeOutOfRangeError: 'Sorry shop is closed now',
        //     onDateChanged: (date) {
        //       setState(() {
        //         _d1 = DateFormat('dd MMM, yyyy').format(date);
        //       });
        //     },
        //     onTimeChanged: (time) {
        //       setState(() {
        //         _t1 = DateFormat('hh:mm:ss aa').format(time);
        //       });
        //     },
        //   ),
        // ),
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
                    'barva': colorInputController.text,
                    'timestamp': dt,
                  }).then((response) {
                    print(response.documentID);
                    Navigator.pop(context);
                    nameInputController.clear();
                    iconInputController.clear();
                    dateInputController.clear();
                    colorInputController.clear();
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
                iconInputController.clear();
                dateInputController.clear();
                colorInputController.clear();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}

Widget colorSwitch(Color color, getColor) {
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
          getColor();
        },
        child: Text(''),
      ),
    ),
  );
}

getColor(String color, TextEditingController controller) {
  controller.text = color;
  return controller.text;
}
