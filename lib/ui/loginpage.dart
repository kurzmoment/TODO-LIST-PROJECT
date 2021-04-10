import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoList/hexcolor.dart';
import 'package:todoList/home.dart';
import 'package:todoList/l10n/l10n.dart';
import 'package:todoList/ui/registerPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoList/util/userSetup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Forgotpass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
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
              AppLocalizations.of(context).resetPassword,
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
        ),
        emailForm(_emailController, context),
        Container(
          alignment: Alignment(-0.9, 0),
          child: TextButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage())),
              child: Text(AppLocalizations.of(context).returnToSignIn)),
        ),
        Container(
          width: 20,
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 40, right: 40),
            child: ElevatedButton(
                style: ButtonStyle(),
                child: Text(AppLocalizations.of(context).submit),
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
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
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
              AppLocalizations.of(context).login,
              style: TextStyle(fontSize: 40, color: Colors.blueAccent.shade200),
            ),
          ),
        ),
        emailForm(_emailController, context),
        passwordForm(_passwordController, context),
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 190, top: 0),
            child: TextButton(
                child: Text(
                  AppLocalizations.of(context).forgotPassword,
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
            child: Text(AppLocalizations.of(context).newHere),
          ),
        ),
        Container(
          width: 20,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: ElevatedButton(
              style: ButtonStyle(),
              child: Text(AppLocalizations.of(context).login),
              onPressed: () async {
                try {
                  User user =
                      (await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ))
                          .user;
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('email', _emailController.text);
                  if (user != null) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }
                } on FirebaseAuthException catch (e) {
                  Fluttertoast.showToast(
                      msg: AppLocalizations.of(context).emailOrPasswordWrong,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      backgroundColor: Colors.blue,
                      textColor: Colors.black);
                  print(e.code);
                  _emailController.text = '';
                  _passwordController.text = '';
                }
              },
            ),
          ),
        )
      ],
    );
  }
}

Widget emailForm(TextEditingController _emailController, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 100),
    child: TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).email,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget passwordForm(
    TextEditingController _passwordController, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 100),
    child: Column(
      children: [
        TextFormField(
          obscureText: true,
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).password,
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
