import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoList/model/Activity_Done_Show.dart';
import 'package:todoList/model/Activity_Future_Show.dart';

class ActivityDoneBuilder extends StatelessWidget {
  var firestoreDb = Firestore.instance.collection("test").snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('test').orderBy('date').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, int index) {
            return ActivityDoneShow(snapshot: snapshot.data, index: index);
          },
        );
      },
    );
  }
}
