// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:todoList/hexcolor.dart';
// import 'package:todoList/home.dart';
// import 'package:todoList/ui/loginpage.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class RegisterPage extends StatelessWidget {
//   // Map<String, IconData> iconPack = {
//   //   'apple': FontAwesomeIcons.apple,
//   //   'google': FontAwesomeIcons.google,
//   //   'facebook': FontAwesomeIcons.facebook
//   // };
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: HexColor('#73BAF5'),
//         body: Container(
//           child: Register(),
//         ),
//       ),
//     );
//   }
// }

// class Register extends StatefulWidget {
//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _rePasswordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 150,
//               child: Image(
//                 image: AssetImage('assets/logo.png'),
//                 height: 120,
//                 width: 120,
//               ),
//             ),
//           ),
//         ),
//         Container(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15, bottom: 20),
//             child: Text(
//               'Register',
//               style: TextStyle(fontSize: 40, color: Colors.white),
//             ),
//           ),
//         ),
//         userNameForm(_usernameController),
//         emailForm(_emailController),
//         passwordForm(_passwordController),
//         passwordConfirmForm(_rePasswordController),
//         Padding(
//           padding: const EdgeInsets.only(top: 25, left: 1),
//           child: Row(
//             children: [
//               loginOptions('google', Colors.black),
//               loginOptions('apple', Colors.black),
//               loginOptions('facebook', Colors.blueAccent.shade700),
//             ],
//           ),
//         ),
//         Container(
//           alignment: Alignment(-0.9, 0),
//           child: TextButton(
//             onPressed: () => Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (context) => LoginPage())),
//             child: Text('Allready have accoutn? Click here.'),
//           ),
//         ),
//         Container(
//           width: 20,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 0, left: 40, right: 40),
//             child: ElevatedButton(
//               style: ButtonStyle(),
//               child: Text('Register'),
//               onPressed: () async {
//                 try {
//                   UserCredential user = await FirebaseAuth.instance
//                           .createUserWithEmailAndPassword(
//                     email: _emailController.text,
//                     password: _passwordController.text,
//                   );
//                       .user;
//                   if (user != null) {
//                     UserUpdateInfo updateUser = UserUpdateInfo();
//                     updateUser.displayName = _usernameController.text;
//                     user.updateProfile(updateUser);
//                     Navigator.of(context).push(
//                         MaterialPageRoute(builder: (context) => HomeScreen()));
//                   }
//                 } catch (e) {
//                   print(e);
//                   _passwordController.text = '';
//                   _rePasswordController.text = '';
//                   _emailController.text = '';
//                   _usernameController.text = '';
//                   // TODO: alertDialog with error
//                 }
//               },
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// Widget emailForm(TextEditingController _emailController) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 15, right: 100),
//     child: Padding(
//       padding: const EdgeInsets.only(left: 10),
//       child: TextFormField(
//         controller: _emailController,
//         decoration: InputDecoration(
//           hintText: 'Email',
//           labelText: 'Email',
//           hintStyle: TextStyle(color: Colors.white),
//           labelStyle: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget passwordForm(TextEditingController _passwordController) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 15, right: 100),
//     child: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 10),
//           child: TextFormField(
//             obscureText: true,
//             controller: _passwordController,
//             decoration: InputDecoration(
//               hintText: 'Password',
//               labelText: 'Password',
//               hintStyle: TextStyle(color: Colors.white),
//               labelStyle: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget passwordConfirmForm(TextEditingController _rePasswordController) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 15, right: 100),
//     child: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 10),
//           child: TextFormField(
//             obscureText: true,
//             controller: _rePasswordController,
//             decoration: InputDecoration(
//               hintText: 'Re-enter Password',
//               labelText: 'Re-enter Password',
//               hintStyle: TextStyle(color: Colors.white),
//               labelStyle: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget userNameForm(TextEditingController _usernameController) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 15, right: 100),
//     child: Padding(
//       padding: const EdgeInsets.only(left: 10),
//       child: TextField(
//         controller: _usernameController,
//         decoration: InputDecoration(
//           focusColor: Colors.white,
//           hintText: 'Username',
//           labelText: 'Username',
//           hintStyle: TextStyle(color: Colors.white),
//           labelStyle: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget loginOptions(String firma, Color color) {
//   Map<String, IconData> iconPack = {
//     'apple': FontAwesomeIcons.apple,
//     'google': FontAwesomeIcons.google,
//     'facebook': FontAwesomeIcons.facebook
//   };
//   return Padding(
//     padding: const EdgeInsets.only(left: 10),
//     child: Container(
//       margin: EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//       ),
//       child: IconButton(
//         icon: FaIcon(
//           iconPack[firma],
//           color: color,
//         ),
//         onPressed: () => debugPrint(firma),
//       ),
//     ),
//   );
// }
