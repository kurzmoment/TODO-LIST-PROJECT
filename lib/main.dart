import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoList/home.dart';
import 'package:todoList/ui/loginpage.dart';
import 'package:todoList/ui/calendaryWithAct.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  await Firebase.initializeApp();
  runApp(email == null ? LoginPage() : HomeScreen());
}
