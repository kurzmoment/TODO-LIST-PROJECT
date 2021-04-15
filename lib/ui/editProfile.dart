import 'package:flutter/material.dart';
import 'package:todoList/hexcolor.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  _showModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container();
        });
  }

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
            margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
            child: ListTile(
              title: Text('Zmena uzivatelskeho jmena'),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  _showModalBottomSheet(context);
                },
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
            child: ListTile(
              title: Text('Zmena emailu'),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
            child: ListTile(
              title: Text('Zmena hesla'),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
            child: ListTile(
              title: Text('Informace o uzivateli'),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 280),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/logo.png'),
                  height: 60,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Version Alpha 0.5.0'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
