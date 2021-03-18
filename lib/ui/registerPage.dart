import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoList/hexcolor.dart';
import 'package:todoList/ui/loginpage.dart';

class RegisterPage extends StatelessWidget {
  // Map<String, IconData> iconPack = {
  //   'apple': FontAwesomeIcons.apple,
  //   'google': FontAwesomeIcons.google,
  //   'facebook': FontAwesomeIcons.facebook
  // };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: HexColor('#D5F3EF'),
        body: Container(
          child: Register(),
        ),
      ),
    );
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150,
              child: Image(
                image: AssetImage('assets/logo.png'),
                height: 120,
                width: 120,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 20),
            child: Text(
              'Register',
              style: TextStyle(fontSize: 40, color: Colors.blueAccent.shade200),
            ),
          ),
        ),
        inputText('Email'),
        emailForm(),
        inputText('Password'),
        passwordForm(),
        inputText('Confirm password'),
        passwordConfirmForm(),
        Padding(
          padding: const EdgeInsets.only(top: 25, left: 1),
          child: Row(
            children: [
              loginOptions('google', Colors.black),
              loginOptions('apple', Colors.black),
              loginOptions('facebook', Colors.blueAccent.shade700),
            ],
          ),
        ),
        Container(
          alignment: Alignment(-0.9, 0),
          child: TextButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage())),
            child: Text('Allready have accoutn? Click here.'),
          ),
        ),
        Container(
          width: 20,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: ElevatedButton(
              style: ButtonStyle(),
              child: Text('Register'),
              onPressed: () => debugPrint('Register'),
            ),
          ),
        )
      ],
    );
  }
}

Widget inputText(String thing) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 15, top: 10),
      child: Text(
        '${thing}',
        style: TextStyle(fontSize: 15, color: Colors.blueAccent.shade200),
      ),
    ),
  );
}

Widget emailForm() {
  return Padding(
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
  );
}

Widget passwordForm() {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 100),
    child: Column(
      children: [
        Container(
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
      ],
    ),
  );
}

Widget passwordConfirmForm() {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 100),
    child: Column(
      children: [
        Container(
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
      ],
    ),
  );
}

Widget loginOptions(String firma, Color color) {
  Map<String, IconData> iconPack = {
    'apple': FontAwesomeIcons.apple,
    'google': FontAwesomeIcons.google,
    'facebook': FontAwesomeIcons.facebook
  };
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: IconButton(
        icon: FaIcon(
          iconPack[firma],
          color: color,
        ),
        onPressed: () => debugPrint(firma),
      ),
    ),
  );
}
