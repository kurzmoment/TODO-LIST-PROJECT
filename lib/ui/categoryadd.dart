import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    var snapshotData = snapshot.docs[index].data;
    var docID = snapshot.docs[index].id;
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
            var collectionReference =
                FirebaseFirestore.instance.collection("Category");
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
              iconMapping[snapshotData],
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

class AddCategoryforActiv extends StatelessWidget {
  // PROBIHAJICI TESTOVANI

  TextEditingController categoryInputController;

  final QuerySnapshot snapshot;
  final int index;
  AddCategoryforActiv({Key key, this.snapshot, this.index}) : super(key: key);
  String dropDownValue = 'NONE';

  @override
  Widget build(BuildContext context) {
    var snapshotData = snapshot.docs[index].data;
    var docID = snapshot.docs[index].id;

    return DropdownButton<String>(
      value: dropDownValue,
      icon: Icon(Icons.arrow_drop_down_outlined),
      iconSize: 25,
      elevation: 15,
      style: TextStyle(color: Colors.black),
      onChanged: (String newValue) {
        {
          dropDownValue = newValue;
          categoryInputController.text = dropDownValue;
        }
      },
      items: <String>[snapshotData['name']]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
