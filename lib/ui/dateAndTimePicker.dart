import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class DateTimePickerOwn extends StatefulWidget {
  final DateAndTime dateAndTime;

  const DateTimePickerOwn({Key key, this.dateAndTime}) : super(key: key);
  @override
  _DateTimePickerOwnState createState() => _DateTimePickerOwnState();
}

class _DateTimePickerOwnState extends State<DateTimePickerOwn> {
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

  void initState() {
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _timeController.text = formatDate(
        DateTime(2021, 03, 16, selectedTime.hour, selectedTime.minute),
        [hh, ':', nn, ' ', am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              style: TextStyle(fontSize: 40),
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
              style: TextStyle(fontSize: 40),
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
    );
  }
}

class DateAndTime {
  final datecontroller;
  final timeController;

  DateAndTime(this.datecontroller, this.timeController);
}
