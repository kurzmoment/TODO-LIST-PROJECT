import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoList/home.dart';
import 'package:todoList/ui/loginpage.dart';
import 'package:todoList/ui/settingLegalThings.dart';
import 'package:todoList/util/app_localizations.dart';
import 'package:todoList/util/theme_provider.dart';
import 'package:todoList/util/userSetup.dart';
import 'calendaryWithAct.dart';
import 'package:todoList/ui/profilePage.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('settings'),
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
            child: Text(
              AppLocalizations.of(context).translate('userSetting'),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
            child: ListTile(
              title: Text(AppLocalizations.of(context)
                  .translate('communityGuidelines')),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CommunityGuidelines()));
                },
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
            child: ListTile(
              title: Text(AppLocalizations.of(context).translate('lang')),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
            child: ListTile(
              title:
                  Text(AppLocalizations.of(context).translate('notification')),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotificationShow()));
                },
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
            child: Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => SwitchListTile(
                title: Text(AppLocalizations.of(context).translate('darkMode')),
                onChanged: (val) {
                  notifier.toggleTheme();
                },
                value: notifier.darkTheme,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
            child: Text(
              AppLocalizations.of(context).translate('legal'),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
            child: ListTile(
              title:
                  Text(AppLocalizations.of(context).translate('privacyPolicy')),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                },
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
            child: ListTile(
              title: Text(
                  AppLocalizations.of(context).translate('termsOfService')),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TermsOfService()));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Card(
              margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context).translate('signOut'),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () async {
                  AuthenticationFacebook.logOutWithFacebook(context);
                  Authentication.signOut(context);
                  FirebaseAuth.instance.signOut();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('email');
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/logo.png'),
                  height: 60,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Version Alpha 0.5.0'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Card(
              margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context).translate('deleteAcc'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
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

// class LanguagePickerWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<LangPreference>(context);
//     return Padding(
//       padding: const EdgeInsets.only(left: 20),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton(
//           value: provider.locale ?? Locale('en', 'US'),
//           icon: Container(
//             width: 12,
//           ),
//           items: [
//               Locale('en', 'US'),
//               Locale('de', 'DE'),
//               Locale('es', 'ES'),
//               Locale('fr', 'FR'),
//               Locale('it', 'IT'),
//               Locale('pt', 'PT'),
//               Locale('cs', 'CZ'),
//               Locale('ru', 'RU'),
//               Locale('ar', 'AE'),
//               Locale('hi', 'IN'),
//               Locale('ko', 'KR'),
//               Locale('zh', 'CH')
//           ].map((locale) {
//             //final flag = L10n.getFlag(locale.languageCode);
//             return DropdownMenuItem(
//               child: Center(
//                 child: Text(
//                   flag.toString(),
//                   style: TextStyle(fontSize: 17),
//                 ),
//               ),
//               value: locale,
//               onTap: () {
//                 final provider =
//                     Provider.of<LangPreference>(context, listen: false);
//                 provider.setLocale(locale);
//               },
//             );
//           }).toList(),
//           onChanged: (_) {},
//         ),
//       ),
//     );
//   }
// }
