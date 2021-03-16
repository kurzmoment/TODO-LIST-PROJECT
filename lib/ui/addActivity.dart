import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddActivity extends StatelessWidget {
  // PROBIHAJICI TESTOVANI
  final QuerySnapshot snapshot;
  final int index;
  AddActivity({Key key, this.snapshot, this.index}) : super(key: key);
  Map<String, IconData> iconMapping = {
    'shopping': FontAwesomeIcons.shoppingCart,
    'gym': FontAwesomeIcons.dumbbell,
    'business': FontAwesomeIcons.briefcase,
    'eat': FontAwesomeIcons.utensils,
    'code': FontAwesomeIcons.code,
    'repair': FontAwesomeIcons.tools,
  };
  Map<String, Color> colorsMapping = {
    'red': Colors.red,
    'blue': Colors.blue,
    'black': Colors.black,
    'green': Colors.green,
    'pink': Colors.pink
  };
  var firebaseDB = Firestore.instance.collection('test').snapshots();
  static var date = DateTime.now();
  final dateFormat = DateFormat('EEEE / dd.MM.yyyy').format(date);

  @override
  Widget build(BuildContext context) {
    var snapshotData = snapshot.documents[index].data;
    var docId = snapshot.documents[index].documentID;

    return StreamBuilder(
      stream: firebaseDB,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, int indexx) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: [
                IconSlideAction(
                  icon: Icons.share,
                  color: Colors.blue,
                  caption: 'Share',
                  onTap: () => debugPrint(''),
                ),
                IconSlideAction(
                  icon: Icons.edit,
                  color: Colors.green,
                  caption: 'Edit',
                  onTap: () => SnackBar(
                    content: Text('Edited'),
                  ),
                ),
                IconSlideAction(
                    icon: Icons.delete,
                    color: Colors.red,
                    caption: 'Delete',
                    onTap: () async {
                      var collectionReference =
                          Firestore.instance.collection("test");
                      await collectionReference
                          .document(docId)
                          .delete()
                          .catchError((error) => print("$error"));
                    }),
              ],
              child: Card(
                shadowColor: Colors.black,
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      iconMapping[snapshot.data.documents[index]['ikona']],
                      color: colorsMapping[snapshot.data.documents[index]
                          ['barva']],
                    ),
                  ),
                  // trailing: IconButton(
                  //   onPressed: () {},
                  //   icon: Padding(
                  //     padding: const EdgeInsets.all(4.0),
                  //     child: FaIcon(FontAwesomeIcons.edit),
                  //   ),
                  // ),
                  title: Text(
                    snapshot.data.documents[index]['title'],
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    snapshot.data.documents[index]['name'],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
