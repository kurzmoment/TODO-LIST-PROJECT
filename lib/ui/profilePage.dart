import 'package:flutter/material.dart';
import 'package:todoList/hexcolor.dart';
import 'package:todoList/home.dart';
import 'package:todoList/ui/editProfile.dart';
import 'package:todoList/ui/listOfActivities.dart';

class AccPage extends StatefulWidget {
  @override
  _AccPageState createState() => _AccPageState();
}

class _AccPageState extends State<AccPage> {
  final colorBottom = HexColor('FCEDC5');
  final colorActivity = HexColor('FF0000');
  final colorBody = HexColor('EEFCFA');
  final colorTop = HexColor('A1E7F7');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBody,
      appBar: AppBar(
        backgroundColor: colorTop,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditProfilePage()));
            },
          ),
        ],
        centerTitle: true,
        title: Text(
          'My profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image(
                  image: AssetImage('assets/marianek.webp'),
                  alignment: Alignment.center,
                  width: 128,
                  height: 128,
                ),
              )
            ],
          ),
          Divider(
            thickness: 2,
            color: Colors.black54,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your name: Jon \'Beverage\' Marianek',
                  style: TextStyle(fontSize: 19, fontFamily: 'Roboto'),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.black38,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your job: Profesional cunt',
                  style: TextStyle(fontSize: 19, fontFamily: 'SanSerif'),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.black38,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your country: USA (fuck czechia)',
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.black38,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your email: jonfckmarianek@beverageinc.gov',
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.black38,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'MOZNA BUDOUCI GRAF NEBO SEZNAM PRATEL',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
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
              onPressed: () {},
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
