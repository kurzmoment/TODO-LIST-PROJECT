import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:intl/intl.dart';
import 'categ.dart';
import 'package:todoList/ui/editActivity.dart';
import 'package:we_slide/we_slide.dart';

class AddCategory extends StatelessWidget {
  // PROBIHAJICI TESTOVANI
  final QuerySnapshot snapshot;
  final int index;
  AddCategory({Key key, this.snapshot, this.index}) : super(key: key);
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
  final firebaseDB = Firestore.instance.collection('Category').snapshots();

  @override
  Widget build(BuildContext context) {
    var snapshotData = snapshot.documents[index].data;
    var docID = snapshot.documents[index].documentID;
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
            icon: Icons.edit,
            color: Colors.green,
            caption: 'Edit',
            onTap: () async {
              //  await showDialog(context: context, child: EditActSlide());
            }),
        IconSlideAction(
          icon: Icons.delete,
          color: Colors.red,
          caption: 'Delete',
          onTap: () async {
            var collectionReference = Firestore.instance.collection("Category");
            await collectionReference
                .document(docID)
                .delete()
                .catchError((error) => print("$error"));
          },
        )
      ],
      child: Card(
        shadowColor: Colors.black,
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              iconMapping[snapshotData['ikona']],
              color: colorsMapping[snapshotData['barva']],
            ),
          ),
          title: Text(
            snapshotData['name'],
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
