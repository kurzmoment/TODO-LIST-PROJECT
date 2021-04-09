import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoList/home.dart';
import 'package:todoList/ui/loginpage.dart';
import 'package:todoList/util/theme_provider.dart';
import 'calendaryWithAct.dart';
import 'package:todoList/ui/profilePage.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).settings,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  AppLocalizations.of(context).language,
                  style: TextStyle(fontSize: 17),
                ),
              )
            ],
          ),
          Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          DropDownSettings(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  AppLocalizations.of(context).notification,
                  style: TextStyle(fontSize: 17),
                ),
              )
            ],
          ),
          Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => SwitchListTile(
                title: Text(AppLocalizations.of(context).notification),
                onChanged: (val) {
                  debugPrint(val.toString());
                },
                value: notifier.darkTheme,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => SwitchListTile(
                title: Text(AppLocalizations.of(context).darkMode),
                onChanged: (val) {
                  notifier.toggleTheme();
                },
                value: notifier.darkTheme,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    child: Text(
                      AppLocalizations.of(context).signOut,
                      style: TextStyle(fontSize: 22),
                    ),
                    onPressed: () async {
                      FirebaseAuth.instance.signOut();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('email');
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    })
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: new BottomAppBar(
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
          ],
        ),
      ),
    );
  }
}

class DropDownSettings extends StatefulWidget {
  @override
  _DropDownSettingsState createState() => _DropDownSettingsState();
}

class _DropDownSettingsState extends State<DropDownSettings> {
  String dropDownValue = 'English';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 5, right: 20),
      child: DropdownButton<String>(
        value: dropDownValue,
        icon: Icon(Icons.arrow_drop_down_outlined),
        iconSize: 25,
        elevation: 15,
        onChanged: (String newValue) {
          setState(() {
            dropDownValue = newValue;
          });
        },
        items: <String>['English', 'Cestina']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
