import 'package:flutter/material.dart';

import 'package:todoList/ui/thisMonthActivity.dart';
import 'oneDayActivity.dart';
import 'package:todoList/ui/thisWeekActivity.dart';

class Activity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: [
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: OneAct(),
          ),
        ),
      ],
    );
  }
}
