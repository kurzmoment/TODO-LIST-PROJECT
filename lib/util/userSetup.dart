import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todoList/ui/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<void> userSetup(String displayName) async {
  //DateTime dt = DateTime.now();
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  CollectionReference users = FirebaseFirestore.instance
      .collection('userData')
      .doc(uid)
      .collection('activity');
  CollectionReference usersCat = FirebaseFirestore.instance
      .collection('userData')
      .doc(uid)
      .collection('categoryPoints');
  return;
}

Future<void> sendPassResMail(String email) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  return await auth.sendPasswordResetEmail(email: email);
}

Future<void> addActivityUID(
    TextEditingController _nameController,
    TextEditingController _iconController,
    TextEditingController _dateController,
    TextEditingController _colorController,
    TextEditingController _timeController,
    TextEditingController _endtimeController,
    TextEditingController _notesController,
    TextEditingController _ocurehowController,
    TextEditingController _ocureID,
    DateTime dt,
    String displayName) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  CollectionReference users = FirebaseFirestore.instance
      .collection('userData')
      .doc(uid)
      .collection('activity');

  users.add({
    'displayName': displayName,
    'uid': uid,
    'name': _nameController.text,
    'ikona': _iconController.text,
    'date': _dateController.text,
    'barva': _colorController.text,
    'time': _timeController.text,
    'etime': _endtimeController.text,
    'notes': _notesController.text,
    "ocurence": _ocurehowController.text,
    "ocureid": _ocureID.text,
    'timestamp': dt,
  });
  return;
}

Future<String> getUID() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  var uid = auth.currentUser.uid.toString();
  return uid;
}

// Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//   // Create a new credential
//   final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }

class Authentication {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<User> signInWithGoogle({BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context)
              .showSnackBar(Authentication.customSnackBar(
            content: 'The account already exists with a different credential.',
          ));
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context)
              .showSnackBar(Authentication.customSnackBar(
            content: 'Error occurred while accessing credentials. Try again.',
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Authentication.customSnackBar(
          content: 'Error occurred using Google Sign-In. Try again.',
        ));
      }
    }
    return user;
  }

  static Future<void> signOut(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  static SnackBar customSnackBar({String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
}

class AuthenticationFacebook {
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<User> signInWithFacebook({BuildContext context}) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User user;
    final FacebookLogin facebookLogin = FacebookLogin();
    final FacebookLoginResult loginResult =
        await facebookLogin.logIn(['email']);
    switch (loginResult.status) {
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
      case FacebookLoginStatus.loggedIn:
        try {
          final FacebookAccessToken facebookAccessToken =
              loginResult.accessToken;
          AuthCredential credential =
              FacebookAuthProvider.credential(facebookAccessToken.token);
          var a = await _auth.signInWithCredential(credential);
          user = a.user;
        } catch (e) {
          print(e);
        }
    }
    return user;
  }

  static Future logOutWithFacebook(BuildContext context) async {
    FacebookLogin fbl = FacebookLogin();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      fbl.logOut();
    } catch (e) {
      print(e);
    }
  }
}
