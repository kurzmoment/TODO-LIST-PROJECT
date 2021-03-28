import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoList/hexcolor.dart';
import 'package:todoList/home.dart';
import 'package:todoList/ui/registerPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoList/util/userSetup.dart';

class Forgotpass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: HexColor('#73BAF5'),
        body: Container(
          child: Forgot(),
        ),
      ),
    );
  }
}

class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  TextEditingController _emailController = TextEditingController();

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
              'Reset Password',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
        ),
        emailForm(_emailController),
        Container(
          alignment: Alignment(-0.9, 0),
          child: TextButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage())),
            child: Text('Return to Sign in'),
          ),
        ),
        Container(
          width: 20,
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 40, right: 40),
            child: ElevatedButton(
                style: ButtonStyle(),
                child: Text('Submit'),
                onPressed: () {
                  //musíme přidat podmínku aby to čeklo jestli tam ten mail je
                  // ta podmínka ti pak vypíše bud špatně zadaná

                  sendPassResMail(_emailController.text);
                  Navigator.of(context).push(
                      // nebo ti tady napíše posláno na mail
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }),
          ),
        )
      ],
    );
  }
}

class LoginPage extends StatelessWidget {
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
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
        emailForm(_emailController),
        passwordForm(_passwordController),
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 190, top: 0),
            child: TextButton(
                child: Text(
                  'Forgot password?',
                  style: TextStyle(color: Colors.blueAccent.shade200),
                ),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Forgotpass()))),
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
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => RegisterPage())),
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
              onPressed: () async {
                try {
                  User user =
                      (await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ))
                          .user;
                  if (user != null) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }
                } catch (e) {
                  print(e);
                  _emailController.text = '';
                  _passwordController.text = '';
                  //TODO : ALERTDIALOG
                }
              },
            ),
          ),
        )
      ],
    );
  }
}

Widget emailForm(TextEditingController _emailController) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 100),
    child: TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: 'Email',
        labelText: 'Email',
        hintStyle: TextStyle(color: Colors.black),
        labelStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget passwordForm(TextEditingController _passwordController) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 100),
    child: Column(
      children: [
        TextFormField(
          obscureText: true,
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: 'Password',
            labelText: 'Password',
            hintStyle: TextStyle(color: Colors.black),
            labelStyle: TextStyle(
              color: Colors.black,
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
