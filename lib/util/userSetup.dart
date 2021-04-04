import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todoList/ui/loginpage.dart';

Future<void> userSetup(String displayName) async {
  //DateTime dt = DateTime.now();
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  CollectionReference users = FirebaseFirestore.instance
      .collection('userData')
      .doc(uid)
      .collection('activity');
  CollectionReference usersCat = FirebaseFirestore.instance
      .collection('userData')
      .doc(uid)
      .collection('Category');
  return;
}

Future<void> sendPassResMail(String email) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  return await auth.sendPasswordResetEmail(email: email);
}

Future<void> addActivityUID(
    TextEditingController _nameController,
    TextEditingController _iconController,
    TextEditingController _dateController,
    TextEditingController _colorController,
    TextEditingController _timeController,
    TextEditingController _endtimeController,
    TextEditingController _notesController,
    DateTime dt,
    String displayName) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  CollectionReference users = FirebaseFirestore.instance
      .collection('userData')
      .doc(uid)
      .collection('activity');
  users.add({
    'displayName': displayName,
    'uid': uid,
    'name': _nameController.text,
    'ikona': _iconController.text,
    'date': _dateController.text,
    'barva': _colorController.text,
    'time': _timeController.text,
    'etime': _endtimeController.text,
    'notes': _notesController.text,
    'timestamp': dt,
  });
  return;
}

Future<String> getUID() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  var uid = auth.currentUser.uid.toString();
  return uid;
}
