import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoList/ui/loginpage.dart';
import 'package:todoList/ui/calendaryWithAct.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginPage());
}
