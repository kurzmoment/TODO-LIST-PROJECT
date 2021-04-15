import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoList/hexcolor.dart';
import 'package:todoList/home.dart';
import 'package:todoList/ui/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoList/util/app_localizations.dart';
import 'package:todoList/util/userSetup.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('de', 'DE'),
        Locale('es', 'ES'),
        Locale('fr', 'FR'),
        Locale('it', 'IT'),
        Locale('pt', 'PT'),
        Locale('cs', 'CZ'),
        Locale('ru', 'RU'),
        Locale('ar', 'AE'),
        Locale('hi', 'IN'),
        Locale('ko', 'KR'),
        Locale('zh', 'CH')
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: Scaffold(
        backgroundColor: HexColor('#73BAF5'),
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
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();
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
              AppLocalizations.of(context).translate('signUp'),
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
        ),
        userNameForm(_usernameController, context),
        emailForm(_emailController, context),
        passwordForm(_passwordController, context),
        passwordConfirmForm(_rePasswordController, context),
        Container(
          alignment: Alignment(-0.9, 0),
          child: TextButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage())),
            child:
                Text(AppLocalizations.of(context).translate('alreadyHaveAcc')),
          ),
        ),
        Container(
          width: 20,
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 40, right: 40),
            child: ElevatedButton(
              style: ButtonStyle(),
              child: Text(AppLocalizations.of(context).translate('signUp')),
              onPressed: () async {
                try {
                  UserCredential user = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  User updateUser = FirebaseAuth.instance.currentUser;
                  updateUser.updateProfile(
                      displayName: _usernameController.text);
                  userSetup(_usernameController.text);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } on FirebaseAuthException catch (e) {
                  Fluttertoast.showToast(
                      msg: e.code,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      backgroundColor: Colors.white,
                      textColor: Colors.black);
                  print(e.code);
                  _usernameController.text = '';
                  _rePasswordController.text = '';
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
    child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate('email'),
          labelStyle: TextStyle(
            color: Colors.white,
          ),
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
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextFormField(
            obscureText: true,
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).translate('password'),
              labelStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget passwordConfirmForm(
    TextEditingController _rePasswordController, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 100),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextFormField(
            obscureText: true,
            controller: _rePasswordController,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).translate('rePassword'),
              labelStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget userNameForm(
    TextEditingController _usernameController, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 100),
    child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: TextField(
        controller: _usernameController,
        decoration: InputDecoration(
          focusColor: Colors.white,
          labelText: AppLocalizations.of(context).translate('username'),
          labelStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
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
