import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoList/ui/addActivity.dart';

class Activity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: [
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: AddActivity(),
          ),
        ),
      ],
    );
  }
}
