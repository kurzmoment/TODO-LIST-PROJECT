import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoList/hexcolor.dart';
import 'package:todoList/home.dart';
import 'package:todoList/ui/editProfile.dart';
import 'package:todoList/util/app_localizations.dart';
import 'calendaryWithAct.dart';

class AccPage extends StatefulWidget {
  final String ikona;

  const AccPage({Key key, this.ikona}) : super(key: key);
  @override
  _AccPageState createState() => _AccPageState();
}

class _AccPageState extends State<AccPage> {
  bool isButtonDisabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditProfilePage()));
            },
          ),
        ],
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('myProfile'),
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  alignment: Alignment.topRight,
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/avatar/avatar1.png'))),
                ),
              ),
              Column(
                children: [
                  Text(FirebaseAuth.instance.currentUser.displayName),
                  Text(FirebaseAuth.instance.currentUser.email),
                  Text(
                      AppLocalizations.of(context).translate('placeForYourJob'))
                ],
              )
            ],
          ),
          Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).translate('statistics'),
                style: TextStyle(fontSize: 22),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  child: Text(
                    AppLocalizations.of(context).translate('clearStat'),
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      HexColor('A1E7F7'),
                    ),
                  ),
                  onPressed: () async {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(AppLocalizations.of(context)
                              .translate('doYouReallyWantExit')),
                          actions: [
                            TextButton(
                                child: Text(AppLocalizations.of(context)
                                    .translate('yes')),
                                onPressed: () async {
                                  var collectionReference = FirebaseFirestore
                                      .instance
                                      .collection('userData');
                                  await collectionReference
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .collection('categoryPoints')
                                      .get()
                                      .then((snapshot) {
                                    for (DocumentSnapshot ds in snapshot.docs) {
                                      ds.reference.delete();
                                    }
                                  }).catchError((error) => print('$error'));
                                  Navigator.of(context).pop();
                                }),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                  AppLocalizations.of(context).translate('no')),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
          StatisticBuilder(),
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
              disabledColor: Colors.grey.shade700,
              onPressed: null,
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

class StatisticBuilder extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('userData')
          .doc(auth.currentUser.uid)
          .collection('categoryPoints')
          .orderBy('point', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, int index) {
              return StatShow(snapshot: snapshot.data, index: index);
            },
          ),
        );
      },
    );
  }
}

class StatShow extends StatefulWidget {
  final QuerySnapshot snapshot;
  final int index;

  const StatShow({Key key, this.snapshot, this.index}) : super(key: key);

  @override
  _StatShowState createState() => _StatShowState();
}

class _StatShowState extends State<StatShow> {
  int pocet = 0;
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> iconsCollection = {
      'shopping': FontAwesomeIcons.shoppingCart,
      'gym': FontAwesomeIcons.dumbbell,
      'business': FontAwesomeIcons.briefcase,
      'eat': FontAwesomeIcons.utensils,
      'code': FontAwesomeIcons.code,
      'repair': FontAwesomeIcons.tools,
    };
    var snapshotName = widget.snapshot.docs[widget.index].get('name');
    var snapshotPoints = widget.snapshot.docs[widget.index].get('point');

    if (snapshotName == 'shopping') {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: ListTile(
            title: Text(snapshotName.toString().toUpperCase()),
            trailing: Text(snapshotPoints.toString()),
            leading: Icon(iconsCollection[snapshotName]),
          ),
        ),
      );
    } else if (snapshotName == 'code') {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: ListTile(
            title: Text(snapshotName.toString().toUpperCase()),
            trailing: Text(snapshotPoints.toString()),
            leading: Icon(iconsCollection[snapshotName]),
          ),
        ),
      );
    } else if (snapshotName == 'business') {
      return new Padding(
        padding: const EdgeInsets.all(4.0),
        child: new Card(
          child: new ListTile(
            title: new Text(snapshotName.toString().toUpperCase()),
            trailing: new Text(snapshotPoints.toString()),
            leading: new Icon(iconsCollection[snapshotName]),
          ),
        ),
      );
    } else if (snapshotName == 'repair') {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: ListTile(
            title: Text(snapshotName.toString().toUpperCase()),
            trailing: Text(snapshotPoints.toString()),
            leading: Icon(iconsCollection[snapshotName]),
          ),
        ),
      );
    } else if (snapshotName == 'eat') {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: ListTile(
            title: Text(snapshotName.toString().toUpperCase()),
            trailing: Text(snapshotPoints.toString()),
            leading: Icon(iconsCollection[snapshotName]),
          ),
        ),
      );
    } else if (snapshotName == 'gym') {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: ListTile(
            title: Text(snapshotName.toString().toUpperCase()),
            trailing: Text(snapshotPoints.toString()),
            leading: Icon(iconsCollection[snapshotName]),
          ),
        ),
      );
    }
  }
}
