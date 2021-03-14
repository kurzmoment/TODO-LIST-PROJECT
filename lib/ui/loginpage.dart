import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoList/hexcolor.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: HexColor('#E5E5E5'),
        body: Container(
          child: Login(),
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 250,
              child: Image(
                image: AssetImage('assets/logo.png'),
                height: 150,
                width: 150,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 20),
            child: Text(
              'Login',
              style: TextStyle(fontSize: 40, color: Colors.blueAccent.shade200),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Email',
              style: TextStyle(fontSize: 15, color: Colors.blueAccent.shade200),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 100),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.blue.shade100, width: 2),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Text(
              'Password',
              style: TextStyle(fontSize: 15, color: Colors.blueAccent.shade200),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 100),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.blue.shade100, width: 2),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 190, top: 5),
            child: Text(
              'Forgot password?',
              style: TextStyle(fontSize: 15, color: Colors.blueAccent.shade200),
            ),
          ),
        ),
      ],
    );
  }
}
