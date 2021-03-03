import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThisMonthAct extends StatelessWidget {
  static var date = DateTime.now();
  var dateFormat = DateFormat('EEEE / dd.MM.yyyy').format(date);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8, right: 100),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(80),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                //color: colorActivity,
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.shop,
                    size: 20,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4),
                    child: Text('Nakup'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6, top: 4),
                    child: Text(
                      '${date.hour}:${date.minute}',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8, left: 150, bottom: 8),
                    child: Icon(
                      Icons.edit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
