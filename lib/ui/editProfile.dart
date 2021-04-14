import 'package:flutter/material.dart';
import 'package:todoList/hexcolor.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        title: Text('Edit your profile',
            style: Theme.of(context).textTheme.headline6),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text('Zmena uzivatelskeho jmena'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Zmena emailu'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Zmena hesla'),
            ),
          )
        ],
      ),
    );
  }
}
