import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoList/model/Activity_Week_Builder.dart';
import 'package:todoList/model/Activity_Month_Builder.dart';
import 'package:todoList/model/Activity_Done_Builder.dart';
import 'package:todoList/model/Activity_Today_Builder.dart';

import 'package:todoList/ui/addBackdrop.dart';
import 'package:todoList/util/theme_provider.dart';
import 'ui/calendaryWithAct.dart';
import 'package:todoList/ui/profilePage.dart';

import 'package:todoList/ui/settings.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            home: Home(),
            theme: notifier.darkTheme ? dark : light,
            navigatorKey: null,
          );
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  static var date = DateTime.now();
  final dateFormat = DateFormat('dd/MM/yyyy kk:mm').format(date);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            alignment: Alignment(0, -0.9),
            icon: const Icon(Icons.settings),
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
        child: displayActivity(),
      ),
      bottomNavigationBar: new BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                icon: Icon(Icons.home),
                disabledColor: Colors.grey.shade600,
                onPressed: null),
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
                })
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
              context, MaterialPageRoute(builder: (context) => AddAct())

              // Navigator.push(
              //   context,
              //   PageTransition(
              //     child: AddAct(),
              //     childCurrent: this,
              //     type: PageTransitionType.bottomToTop,
              //     duration: Duration(milliseconds: 300),
              //     reverseDuration: Duration(milliseconds: 300),
              //     curve: Curves.easeInOut,
              //   ),
              );
        },
      ),
    );
  }
}

Widget displayActivity() {
  return ListView(children: [
    Text(
      'Done',
      style: TextStyle(fontSize: 20),
    ),
    Divider(),
    ActivityDoneBuilder(),
    Text(
      'Today',
      style: TextStyle(fontSize: 20),
    ),
    Divider(),
    ActivityTodayBuilder(),
    Text(
      'This week',
      style: TextStyle(fontSize: 20),
    ),
    Divider(),
    ActivityWeekBuilder(),
    Text(
      'This month',
      style: TextStyle(fontSize: 20),
    ),
    Divider(),
    ActivityMonthBuilder(),
  ]);
}
