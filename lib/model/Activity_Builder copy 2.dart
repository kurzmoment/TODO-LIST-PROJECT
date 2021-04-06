import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoList/model/Activity_Donee_Show.dart';
import 'package:todoList/model/Activity_Today_Show.dart';
import 'package:todoList/model/Activity_This_Month.dart';
import 'package:todoList/model/Activity_This_Week.dart';

class ActivityTodayBuilder extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('userData')
          .doc(auth.currentUser.uid)
          .collection('activity')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, int index) {
            return ActivityTodayShow(
              snapshot: snapshot.data,
              index: index,
            );
          },
        );
      },
    );
  }
}

class ActivityDoneBuilder extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('userData')
          .doc(auth.currentUser.uid)
          .collection('activity')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, int index) {
            return ActivityDoneShow(
              snapshot: snapshot.data,
              index: index,
            );
          },
        );
      },
    );
  }
}

class ActivityWeekBuilder extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('userData')
          .doc(auth.currentUser.uid)
          .collection('activity')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, int index) {
            return ActivityWeekShow(
              snapshot: snapshot.data,
              index: index,
            );
          },
        );
      },
    );
  }
}

class ActivityMonthBuilder extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('userData')
          .doc(auth.currentUser.uid)
          .collection('activity')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, int index) {
            return ActivityMonthShow(
              snapshot: snapshot.data,
              index: index,
            );
          },
        );
      },
    );
  }
}
