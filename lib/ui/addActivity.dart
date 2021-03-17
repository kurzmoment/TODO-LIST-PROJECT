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
<<<<<<< HEAD

  Map<String, IconData> iconMapping = {
=======
  final Map<String, IconData> iconMapping = {
>>>>>>> 75795a4ea6f89f4c5f77d88319a14a8f141ccc34
    'shopping': FontAwesomeIcons.shoppingCart,
    'gym': FontAwesomeIcons.dumbbell,
    'business': FontAwesomeIcons.briefcase,
    'eat': FontAwesomeIcons.utensils,
    'code': FontAwesomeIcons.code,
    'repair': FontAwesomeIcons.tools,
  };
  final Map<String, Color> colorsMapping = {
    'red': Colors.red,
    'black': Colors.black,
    'blue': Colors.blue,
    'green': Colors.green,
    'pink': Colors.pink,
    'yellow': Colors.yellow,
    'lightBlue': Colors.lightBlue,
    'lightGreen': Colors.lightGreen,
    'purple': Colors.purple,
    'amberAccent': Colors.amberAccent
  };
  final firebaseDB = Firestore.instance.collection('test').snapshots();
  static var date = DateTime.now();
  final dateFormat = DateFormat('EEEE / dd.MM.yyyy').format(date);

  @override
  Widget build(BuildContext context) {
    var snapshotData = snapshot.documents[index].data;
<<<<<<< HEAD
    // var docId = snapshot.documents[index].documentID;

    return StreamBuilder(
      stream: firebaseDB,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, int index) {
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
                    onTap: () => {
                          //    var collectionReference =
                          //        Firestore.instance.collection("test");
                          //   await collectionReference
                          //      .document(docId)
                          //    .delete()
                          //   .catchError((error) => print("$error"));
                        }),
              ],
              child: Card(
                shadowColor: Colors.black,
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(4.0),
                    // child: Icon(
                    //   iconMapping[snapshot.data.documents[index]['ikona']],
                    //   color: colorsMapping[snapshot.data.documents[index]
                    //     ['barva']],
                    // ),
                  ),
                  //  title: Text(
                  //     snapshot.data.documents[index]['name'],
                  //    style: TextStyle(fontSize: 20),
                ),
                //    subtitle: Text(
                //      '${snapshot.data.documents[index]['date']}, ${snapshot.data.documents[index]['time']}'),
              ),
              // ),
            );
=======
    var docID = snapshot.documents[index].documentID;

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
            var collectionReference = Firestore.instance.collection("test");
            await collectionReference
                .document(docID)
                .delete()
                .catchError((error) => print("$error"));
>>>>>>> 75795a4ea6f89f4c5f77d88319a14a8f141ccc34
          },
        )
      ],
      child: Card(
        shadowColor: Colors.black,
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              iconMapping[snapshotData['ikona']],
              color: colorsMapping[snapshotData['barva']],
            ),
          ),
          title: Text(
            snapshotData['name'],
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Text('${snapshotData['date']}, ${snapshotData['time']}'),
        ),
      ),
    );
  }
}
