import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoList/home.dart';
import 'categoryaddBackdrop.dart';
import 'package:todoList/ui/category.dart';
import 'package:todoList/ui/categoryaddBackdrop.dart';
import 'calendaryWithAct.dart';
import 'package:todoList/ui/profilePage.dart';
import 'package:todoList/ui/settings.dart';
import 'package:todoList/hexcolor.dart';
import 'category.dart';

class Categoryscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: lightThemeData(context),
      //darkTheme: darkThemeData(context),
      home: CategoryHome(),
    );
  }
}

class CategoryHome extends StatelessWidget {
  final colorBottom = HexColor('FCEDC5');
  final colorActivity = HexColor('FF0000');
  final colorBody = HexColor('EEFCFA');
  final colorTop = HexColor('A1E7F7');
  static var date = DateTime.now();
  final dateFormat = DateFormat('EEEE / dd.MM.yyyy').format(date);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBody,
      appBar: AppBar(
        toolbarHeight: 120,
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('assets/logo.png'),
                fit: BoxFit.contain,
                height: 70,
                width: 70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${dateFormat.toString()}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: colorTop,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            alignment: Alignment(0, -0.9),
            icon: const Icon(Icons.settings),
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  alignment: Alignment.bottomCenter,
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  type: PageTransitionType.rightToLeft,
                  child: Settings(),
                  childCurrent: this,
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Category(),
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
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AccPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.calendar_today_rounded),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListOfActivities()));
              },
            ),
            IconButton(
              icon: Icon(Icons.album),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Categoryscreen()));
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCat()),
          );
        },
      ),
    );
  }
}