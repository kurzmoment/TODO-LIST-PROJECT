import 'package:flutter/material.dart';

import 'package:todoList/ui/thisMonthActivity.dart';
import 'oneDayActivity.dart';
import 'package:todoList/ui/thisWeekActivity.dart';

class Activity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 8),
              child: Text('dnes'),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          color: Colors.black38,
          indent: 20,
          endIndent: 20,
        ),
        OneAct(),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 8),
              child: Text('tento tyden'),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          color: Colors.black38,
          indent: 20,
          endIndent: 20,
        ),
        ThisWeekAct(),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 8),
              child: Text('tento mesic'),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          color: Colors.black38,
          indent: 20,
          endIndent: 20,
        ),
        ThisMonthAct(),
        ThisMonthAct(),
        ThisMonthAct(),
      ],
    );
  }
}
