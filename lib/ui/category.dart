import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'categoryadd.dart';
import 'package:todoList/ui/categoryadd.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  var firestoreDb =
      FirebaseFirestore.instance.collection("Category").snapshots();

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
  var firestoreDb =
      FirebaseFirestore.instance.collection("Category").snapshots();

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
