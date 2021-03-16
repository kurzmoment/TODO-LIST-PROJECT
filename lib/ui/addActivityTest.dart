import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OneAct extends StatefulWidget {
  @override
  _OneActState createState() => _OneActState();
}

class _OneActState extends State<OneAct> {
  final Map<String, IconData> iconMapping = {
    'shopping': FontAwesomeIcons.shoppingCart,
    'gym': FontAwesomeIcons.dumbbell,
    'business': FontAwesomeIcons.briefcase,
    'eat': FontAwesomeIcons.utensils,
    'code': FontAwesomeIcons.code,
    'repair': FontAwesomeIcons.tools,
  };
  final Map<String, Color> colorsMapping = {
    'red': Colors.red,
    'black': Colors.black,
    'blue': Colors.blue,
    'green': Colors.green,
    'pink': Colors.pink,
    'yellow': Colors.yellow,
    'lightBlue': Colors.lightBlue,
    'lightGreen': Colors.lightGreen,
    'purple': Colors.purple,
    'amberAccent': Colors.amberAccent
  };
  var firebaseDB = Firestore.instance.collection('test').snapshots();
  static var date = DateTime.now();
  var dateFormat = DateFormat('EEEE / dd.MM.yyyy').format(date);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firebaseDB,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, int index) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: [
                IconSlideAction(
                  icon: Icons.share,
                  color: Colors.blue,
                  caption: 'Share',
                  onTap: () => SnackBar(
                    content: Text('Shared'),
                  ),
                ),
                IconSlideAction(
                  icon: Icons.edit,
                  color: Colors.green,
                  caption: 'Edit',
                  onTap: () => SnackBar(
                    content: Text('Edited'),
                  ),
                ),
                IconSlideAction(
                  icon: Icons.delete,
                  color: Colors.red,
                  caption: 'Delete',
                  //onTap: () => snapshot.data.documents[index]['barva'],
                ),
              ],
              child: Card(
                shadowColor: Colors.black,
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      iconMapping[snapshot.data.documents[index]['ikona']],
                      color: colorsMapping[snapshot.data.documents[index]
                          ['barva']],
                    ),
                  ),
                  title: Text(
                    snapshot.data.documents[index]['title'],
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(snapshot.data.documents[index]['name']),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
