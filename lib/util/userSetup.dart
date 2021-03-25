import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future<void> userSetup(String displayName) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  CollectionReference users = FirebaseFirestore.instance
      .collection('userData')
      .doc(uid)
      .collection('activity');
  users.add({
    'displayName': displayName,
    'uid': uid,
  });
  return;
}

Future<void> addActivityUID(
    TextEditingController _nameController,
    TextEditingController _categoryController,
    TextEditingController _iconController,
    TextEditingController _dateController,
    TextEditingController _colorController,
    TextEditingController _timeController,
    TextEditingController _notesController,
    DateTime dt) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  CollectionReference users = FirebaseFirestore.instance
      .collection('userData')
      .doc(uid)
      .collection('activity');
  users.add({
    'name': _nameController.text,
    'category': _categoryController.text,
    'ikona': _iconController.text,
    'date': _dateController.text,
    'barva': _colorController.text,
    'time': _timeController.text,
    'notes': _notesController.text,
    'timestamp': dt,
  });
  return;
}
