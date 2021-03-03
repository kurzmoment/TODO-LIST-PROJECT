import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'hexcolor.dart';
import 'package:todoList/ui/activities.dart';

class HomeScreen extends StatelessWidget {
  final colorBottom = HexColor('FCEDC5');
  final colorActivity = HexColor('FF0000');
  final colorTop = HexColor('A1E7F7');
  static var date = DateTime.now();
  var dateFormat = DateFormat('EEEE / dd.MM.yyyy').format(date);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: HexColor('EEFCFA'),
        appBar: AppBar(
          toolbarHeight: 120,
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('assets/marianek.webp'),
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
              onPressed: () => debugPrint('StisknutoTlacitko'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Activity(),
        ),
        bottomNavigationBar: new BottomAppBar(
          color: colorBottom,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () => debugPrint('Home'),
              ),
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () => debugPrint('Account'),
              ),
            ],
          ),
        ),
        floatingActionButton: Align(
          child: FloatingActionButton(
            child: Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () => debugPrint('Floating action button was pressed'),
          ),
          alignment: Alignment(1, 1.1),
        ),
      ),
    );
  }
}
