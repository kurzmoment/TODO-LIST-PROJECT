import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoList/model/Activity_Today_Show.dart';

class ActivityTodayBuilder extends StatelessWidget {
  var firestoreDb = FirebaseFirestore.instance.collection("test").snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestoreDb,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, int index) {
            return ActivityTodayShow(snapshot: snapshot.data, index: index);
          },
        );
      },
    );
  }
}
