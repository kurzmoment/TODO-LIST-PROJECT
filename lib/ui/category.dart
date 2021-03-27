import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'categoryadd.dart';
import 'package:todoList/ui/categoryadd.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("userData")
          .doc(auth.currentUser.uid)
          .collection('Category')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, int index) {
            return AddCategory(snapshot: snapshot.data, index: index);
          },
        );
      },
    );
  }
}

class Categoryforactiv extends StatefulWidget {
  @override
  _CategoryStateforactiv createState() => _CategoryStateforactiv();
}

class _CategoryStateforactiv extends State<Categoryforactiv> {
  var firestoreDb = FirebaseFirestore.instance
      .collection("userData")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('Category')
      .snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestoreDb,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, int index) {
            return AddCategoryforActiv(snapshot: snapshot.data, index: index);
          },
        );
      },
    );
  }
}
