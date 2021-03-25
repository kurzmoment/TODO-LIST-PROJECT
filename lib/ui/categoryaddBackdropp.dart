import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_picker/icon_picker.dart';

import 'categ.dart';

import 'package:todoList/ui/categ.dart';

class AddCatForms extends StatefulWidget {
  @override
  _AddCatFormsState createState() => _AddCatFormsState();
}

class _AddCatFormsState extends State<AddCatForms> {
  // DATE AND TIME PICK

  // DATE AND TIME PICK
  TextEditingController nameInputController;
  TextEditingController notesInputController;
  TextEditingController categoryInputController;
  TextEditingController iconInputController;
  TextEditingController colorInputController;

  void initState() {
    super.initState();
    iconInputController = new TextEditingController();
    nameInputController = new TextEditingController();

    colorInputController = new TextEditingController();
  }

  String initalValue = 'icon';

  Color screenPickerColor = Colors.black;

  final Map<String, IconData> iconsCollection = {
    'shopping': FontAwesomeIcons.shoppingCart,
    'gym': FontAwesomeIcons.dumbbell,
    'business': FontAwesomeIcons.briefcase,
    'eat': FontAwesomeIcons.utensils,
    'code': FontAwesomeIcons.code,
    'repair': FontAwesomeIcons.tools,
    'default': FontAwesomeIcons.question
  };
  String dropDownValue = 'NONE';
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: TextField(
            decoration: InputDecoration(
              helperText: 'Enter a name of category',
            ),
            controller: nameInputController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: IconPicker(
            initialValue: null,
            icon: Icon(Icons.apps),
            labelText: "Icon",
            title: "Select an icon",
            cancelBtn: 'Cancel',
            enableSearch: false,
            iconCollection: iconsCollection,
            controller: iconInputController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                colorSwitch(Colors.red, 'red', colorInputController),
                colorSwitch(Colors.black, 'black', colorInputController),
                colorSwitch(Colors.blue, 'blue', colorInputController),
                colorSwitch(Colors.green, 'green', colorInputController),
                colorSwitch(Colors.pink, 'pink', colorInputController),
                colorSwitch(Colors.yellow, 'yellow', colorInputController),
                colorSwitch(
                    Colors.lightBlue, 'lightBlue', colorInputController),
                colorSwitch(
                    Colors.lightGreen, 'lightGreen', colorInputController),
                colorSwitch(Colors.purple, 'purple', colorInputController),
                colorSwitch(
                    Colors.amberAccent, 'amberAccent', colorInputController),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text(
                'Save',
                style: TextStyle(fontSize: 25),
              ),
              onPressed: () {
                if (nameInputController.text.isNotEmpty) {
                  FirebaseFirestore.instance.collection('Category').add({
                    'name': nameInputController.text,
                    'ikona': iconInputController.text,
                    'barva': colorInputController.text,
                  }).then((response) {
                    print(response.id);
                    Navigator.pop(context);
                    nameInputController.clear();

                    iconInputController.clear();

                    colorInputController.clear();
                  }).catchError((error) => print(error));
                }
              },
            ),
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 25),
              ),
              onPressed: () {
                if (nameInputController.text.isNotEmpty &&
                    iconInputController.text.isNotEmpty &&
                    colorInputController.text.isNotEmpty) {
                  return showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Do you really want exit?'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Text(
                                    'You make some changes do you really want to exit?')
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: Text('Yes'),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) => Categoryscreen()));
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No'),
                            )
                          ],
                        );
                      });
                }
                nameInputController.clear();

                iconInputController.clear();

                colorInputController.clear();

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}

Widget colorSwitch(
    Color color, String colorController, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color,
      ),
      width: 35,
      height: 35,
      child: TextButton(
        onPressed: () {
          controller.text = colorController;
        },
        child: Text(''),
      ),
    ),
  );
}
