import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestDB extends StatefulWidget {
  @override
  _TestDBState createState() => _TestDBState();
}

class _TestDBState extends State<TestDB> {
  var firebaseDB = Firestore.instance.collection('test').snapshots();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: firebaseDB,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, int index) {
                return Text(snapshot.data.documents[index]['title']);
              },
            );
          }),
    );
  }
}
