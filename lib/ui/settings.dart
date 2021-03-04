import 'package:flutter/material.dart';
import 'package:todoList/home.dart';
import 'package:todoList/ui/listOfActivities.dart';

import '../hexcolor.dart';

class Settings extends StatelessWidget {
  final colorTop = HexColor('A1E7F7');
  final colorBottom = HexColor('FCEDC5');
  final colorActivity = HexColor('FF0000');
  final colorBody = HexColor('EEFCFA');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBody,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: colorTop,
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'language',
                  style: TextStyle(fontSize: 17),
                ),
              )
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.black38,
            indent: 20,
            endIndent: 20,
          ),
          DropDownSettings(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 30),
                child: Text(
                  'notifaction',
                  style: TextStyle(fontSize: 17),
                ),
              )
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.black38,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 5),
                child: Text('get notifications'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 215, top: 5),
                child: SwitcherSettings(),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 5),
                child: Text('dark mode'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 250, top: 5),
                child: SwitcherSettings(),
              ),
            ],
          ),
        ],
      ),
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListOfActivities()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DropDownSettings extends StatefulWidget {
  @override
  _DropDownSettingsState createState() => _DropDownSettingsState();
}

class _DropDownSettingsState extends State<DropDownSettings> {
  String dropDownValue = 'English';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: DropdownButton<String>(
        value: dropDownValue,
        icon: Icon(Icons.arrow_drop_down_outlined),
        iconSize: 25,
        elevation: 15,
        style: TextStyle(color: Colors.black),
        onChanged: (String newValue) {
          setState(() {
            dropDownValue = newValue;
          });
        },
        items: <String>['English', 'Cestina']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

class SwitcherSettings extends StatefulWidget {
  @override
  _SwitcherSettingsState createState() => _SwitcherSettingsState();
}

class _SwitcherSettingsState extends State<SwitcherSettings> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(
          () {
            isSwitched = value;
            print(isSwitched);
          },
        );
      },
      activeTrackColor: Colors.lightGreenAccent,
      activeColor: Colors.green,
    );
  }
}
