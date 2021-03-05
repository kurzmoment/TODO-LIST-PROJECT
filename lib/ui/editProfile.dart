import 'package:flutter/material.dart';
import 'package:todoList/hexcolor.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final colorBottom = HexColor('FCEDC5');
  final colorActivity = HexColor('FF0000');
  final colorBody = HexColor('EEFCFA');
  final colorTop = HexColor('A1E7F7');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTop,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        title: Text(
          'Edit your profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              child: Text('Your first name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextField(
              maxLength: 20,
              decoration: InputDecoration(icon: Icon(Icons.person)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              child: Text('Your second name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextField(
              maxLength: 20,
              decoration: InputDecoration(icon: Icon(Icons.person)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              child: Text('Your job'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextField(
              maxLength: 20,
              decoration: InputDecoration(icon: Icon(Icons.work)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              child: Text('Your email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextField(
              maxLength: 20,
              decoration:
                  InputDecoration(icon: Icon(Icons.alternate_email_rounded)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              child: Text('Your password'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextField(
              maxLength: 20,
              decoration: InputDecoration(
                icon: Icon(Icons.vpn_key),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
