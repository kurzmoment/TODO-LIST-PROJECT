import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoList/model/Activity_Week_Builder.dart';
import 'package:todoList/model/Activity_Month_Builder.dart';
import 'package:todoList/model/Activity_Done_Builder.dart';
import 'package:todoList/model/Activity_Today_Builder.dart';
import 'package:todoList/ui/addBackdrop.dart';
import 'package:todoList/util/app_localizations.dart';
import 'package:todoList/util/theme_provider.dart';
import 'ui/calendaryWithAct.dart';
import 'package:todoList/ui/profilePage.dart';
import 'package:todoList/ui/settings.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (
          context,
          ThemeNotifier notifier,
          child,
        ) {
          return MaterialApp(
            home: Home(),
            theme: notifier.darkTheme ? dark : light,
            // navigatorKey: null,
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
          );
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  static var date = DateTime.now();
  final dateFormat = DateFormat('dd/MM/yyyy kk:mm').format(date);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('assets/logo.png'),
                fit: BoxFit.contain,
                height: 70,
                width: 70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${dateFormat.toString()}',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            alignment: Alignment(0, -0.9),
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  alignment: Alignment.bottomCenter,
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  type: PageTransitionType.rightToLeft,
                  child: Settings(),
                  // childCurrent: this,
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: displayActivity(context),
      ),
      bottomNavigationBar: new BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                icon: Icon(Icons.home),
                disabledColor: Colors.grey.shade600,
                onPressed: null),
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
                })
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddAct()));
        },
      ),
    );
  }
}

Widget displayActivity(BuildContext context) {
  return ListView(children: [
    Text(
      AppLocalizations.of(context).translate('done'),
      style: TextStyle(fontSize: 20),
    ),
    Divider(),
    ActivityDoneBuilder(),
    Text(
      AppLocalizations.of(context).translate('today'),
      style: TextStyle(fontSize: 20),
    ),
    Divider(),
    ActivityTodayBuilder(),
    Text(
      AppLocalizations.of(context).translate('thisWeek'),
      style: TextStyle(fontSize: 20),
    ),
    Divider(),
    ActivityWeekBuilder(),
    Text(
      AppLocalizations.of(context).translate('thisMonth'),
      style: TextStyle(fontSize: 20),
    ),
    Divider(),
    ActivityMonthBuilder(),
  ], scrollDirection: Axis.vertical);
}
