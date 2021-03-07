import 'package:flutter/material.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:intl/intl.dart';

class AddActForms extends StatefulWidget {
  @override
  _AddActFormsState createState() => _AddActFormsState();
}

class _AddActFormsState extends State<AddActForms> {
  var _d1;
  var _t1;
  DateTime dt = new DateTime.now();
  Color screenPickerColor = Colors.black;
  final Map<String, IconData> iconsCollection = {
    'favorite': Icons.favorite,
    'home': Icons.home,
    'android': Icons.android,
    'album': Icons.album,
    'ac_unit': Icons.ac_unit,
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: IconPicker(
            initialValue: 'favorite',
            icon: Icon(Icons.apps),
            labelText: "Icon",
            title: "Select an icon for your activity",
            cancelBtn: 'CANCEL',
            enableSearch: true,
            searchHint: 'Search icons',
            iconCollection: iconsCollection, // muze a nemusi byt
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
          child: DateTimePicker(
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
      ],
    );
  }
}
