import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoList/home.dart';
import 'package:todoList/ui/editProfile.dart';
import 'calendaryWithAct.dart';

class AccPage extends StatefulWidget {
  @override
  _AccPageState createState() => _AccPageState();
}

class _AccPageState extends State<AccPage> {
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
          'My profile',
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
                          image: AssetImage('assets/marianek.webp'))),
                ),
              ),
              Column(
                children: [
                  Text(FirebaseAuth.instance.currentUser.displayName),
                  Text(FirebaseAuth.instance.currentUser.email),
                  Text('Place for your job')
                ],
              )
            ],
          ),
          Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Text(
            'STATISTICS',
            style: TextStyle(fontSize: 22),
          ),
          Container(
            child: ProfileBuilder(),
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

class CardCategory extends StatefulWidget {
  final QuerySnapshot snapshot;
  final int index;

  const CardCategory({Key key, this.snapshot, this.index}) : super(key: key);
  @override
  _CardCategoryState createState() => _CardCategoryState();
}

class _CardCategoryState extends State<CardCategory> {
  int pocet = 0;
  TextEditingController _iconController;
  void initState() {
    // POTREBA NASTAVIT PRIDAVANI POCTU, JESTE TEDA ZALEZI KVULI CEMU SE TO BUDE PRICITAT
    // JESTLI PODLE POCTU STEJNEJCH KATEGORII NEBO PRI SPLNENI URCITY KATEGORIE

    super.initState();
    _iconController = new TextEditingController();
  }

  void dispose() {
    pocet = 0;
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
    var snapshotIcon = widget.snapshot.docs[widget.index].get('ikona');
    _iconController = TextEditingController(text: snapshotIcon);
    if (_iconController.text != _iconController.text) {
      pocet = 1;
    } else {
      pocet++;
    }
    if (_iconController.text != 'gym') {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: ListTile(
            title: Text(_iconController.text.toString().toUpperCase()),
            trailing: Text(pocet.toString()),
            leading: Icon(iconsCollection[_iconController.text]),
          ),
        ),
      );
    } else {
      return Container(
        color: Colors.red,
        child: Text('deje se neco?'),
        width: 0,
        height: 0,
      );
    }
  }
}

class ProfileBuilder extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('userData')
          .doc(auth.currentUser.uid)
          .collection('activity')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, int index) {
              return CardCategory(snapshot: snapshot.data, index: index);
            },
          ),
        );
      },
    );
  }
}
