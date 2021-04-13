import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoList/home.dart';
import 'package:todoList/ui/loginpage.dart';
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
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final provider = Provider.of<LangPreference>(context, listen: false);
  //     provider.clearLocale();
  //   });
  // }

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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  AppLocalizations.of(context).translate('lang'),
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
          // LanguagePickerWidget(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  AppLocalizations.of(context).translate('notification'),
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
          // Padding(
          //   padding: const EdgeInsets.only(left: 10),
          //   child: Consumer<ThemeNotifier>(
          //     builder: (context, notifier, child) => SwitchListTile(
          //       title: Text(AppLocalizations.of(context).notification),
          //       onChanged: (val) {
          //         debugPrint(val.toString());
          //       },
          //       value: notifier.darkTheme,
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
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
            padding: const EdgeInsets.only(top: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    child: Text(
                      AppLocalizations.of(context).translate('signOut'),
                      style: TextStyle(fontSize: 22),
                    ),
                    onPressed: () async {
                      AuthenticationFacebook.logOutWithFacebook(context);
                      Authentication.signOut(context);
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
