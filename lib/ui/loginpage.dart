import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoList/hexcolor.dart';

class LoginPage extends StatelessWidget {
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
    return ListView(
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
        inputText('Email'),
        emailForm(),
        inputText('Password'),
        passwordForm(),
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 190, top: 0),
            child: TextButton(
              child: Text(
                'Forgot password?',
                style: TextStyle(color: Colors.blueAccent.shade200),
              ),
              onPressed: () => debugPrint('forgot password?'),
            ),
          ),
        ),
        Row(
          children: [
            loginOptions('google', Colors.black),
            loginOptions('apple', Colors.black),
            loginOptions('facebook', Colors.blueAccent.shade700),
          ],
        ),
        Container(
          alignment: Alignment(-0.9, 0),
          child: TextButton(
            onPressed: () => debugPrint('New here? Register.'),
            child: Text('New here? Register.'),
          ),
        ),
        Container(
          width: 20,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: ElevatedButton(
              style: ButtonStyle(),
              child: Text('Login'),
              onPressed: () => debugPrint('login'),
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
              suffixIcon: showPassword(),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget showPassword() {
  return IconButton(
    icon: FaIcon(
      FontAwesomeIcons.eye,
      color: Colors.black38,
    ),
    onPressed: () => debugPrint('oko stisknuto'),
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
