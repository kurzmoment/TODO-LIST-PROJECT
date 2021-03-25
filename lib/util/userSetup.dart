import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
