import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoList/util/userSetup.dart';
import 'package:todoList/hexcolor.dart';
import 'package:todoList/util/app_localizations.dart';

class EditProfilePage extends StatefulWidget {
  final QuerySnapshot snapshot;
  final int index;

  const EditProfilePage({Key key, this.snapshot, this.index}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var userName = TextEditingController();
  var _oldPassword = TextEditingController();
  var _newPassword = TextEditingController();
  var _reNewPassword = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  bool checkCurrentPasswordValid = true;

  void initState() {
    super.initState();
  }

  void dispose() {
    userName.dispose();
    _oldPassword.dispose();
    _newPassword.dispose();
    _reNewPassword.dispose();
    super.dispose();
  }

  _showModalBottomSheet1(context) {
    var userName = FirebaseAuth.instance.currentUser.displayName;
    var _userNameController = TextEditingController(text: userName);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 50, right: 30),
                  child: TextField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText:
                          AppLocalizations.of(context).translate('username'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 40,
                    width: 350,
                    child: ElevatedButton(
                      child: Text(
                          AppLocalizations.of(context).translate('submit')),
                      onPressed: () async {
                        FirebaseAuth.instance.currentUser.updateProfile(
                            displayName: _userNameController.text);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: 40,
                    width: 350,
                    child: ElevatedButton(
                      child: Text(
                          AppLocalizations.of(context).translate('cancel')),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _showModalBottomSheet2(context) {
    // var docId = widget.snapshot.docs[widget.index].id;
    // userName = new TextEditingController(
    //     text: FirebaseAuth.instance.currentUser.displayName);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 50, right: 30),
                child: TextField(
                  controller: userName,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email),
                    labelText: AppLocalizations.of(context).translate('email'),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String newName) =>
                      {userName = new TextEditingController(text: newName)},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 40,
                  width: 350,
                  child: ElevatedButton(
                    child:
                        Text(AppLocalizations.of(context).translate('submit')),
                    onPressed: () async {
                      FirebaseFirestore.instance
                          .collection('userData')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection('activity')
                          .doc()
                          .set({'displayName': userName.text});
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 40,
                  width: 350,
                  child: ElevatedButton(
                    child:
                        Text(AppLocalizations.of(context).translate('cancel')),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _showModalBottomSheet3(context) {
    // var docId = widget.snapshot.docs[widget.index].id;
    // userName = new TextEditingController(
    //     text: FirebaseAuth.instance.currentUser.displayName);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 50, right: 30),
                    child: TextFormField(
                      obscureText: true,
                      controller: _oldPassword,
                      decoration: InputDecoration(
                        errorText: checkCurrentPasswordValid
                            ? ""
                            : 'Please double check your current password',
                        prefixIcon: Icon(Icons.vpn_key),
                        labelText:
                            AppLocalizations.of(context).translate('password'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 20, right: 30),
                    child: TextFormField(
                      obscureText: true,
                      controller: _newPassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key),
                        labelText:
                            AppLocalizations.of(context).translate('password'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 20, right: 30),
                    child: TextFormField(
                      obscureText: true,
                      controller: _reNewPassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key),
                        labelText:
                            AppLocalizations.of(context).translate('password'),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        return _newPassword.text == value
                            ? null
                            : "Please validate your entered password";
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: 40,
                      width: 350,
                      child: ElevatedButton(
                        child: Text(
                            AppLocalizations.of(context).translate('submit')),
                        onPressed: () async {
                          if (_formKey.currentState.validate() &&
                              checkCurrentPasswordValid) {
                            FirebaseAuth.instance.currentUser
                                .updatePassword(_newPassword.text);
                            Navigator.pop(context);
                          }
                          checkCurrentPasswordValid =
                              await validateCurrentPassword(_newPassword.text);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 40,
                      width: 350,
                      child: ElevatedButton(
                        child: Text(
                            AppLocalizations.of(context).translate('cancel')),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
                  return SingleChildScrollView(
                      child: _showModalBottomSheet1(context));
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
                onPressed: () {
                  return SingleChildScrollView(
                      child: _showModalBottomSheet2(context));
                },
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
            child: ListTile(
              title: Text('Zmena hesla'),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  return _showModalBottomSheet3(context);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300),
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

class EditProfileBuilder extends StatelessWidget {
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
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, int index) {
              return EditProfilePage(
                snapshot: snapshot.data,
                index: index,
              );
            },
          ),
        );
      },
    );
  }
}
