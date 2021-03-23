import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:intl/intl.dart';
import 'package:we_slide/we_slide.dart';

import '../home.dart';

class EditActTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreDb =
        FirebaseFirestore.instance.collection('test').snapshots();
    final double _panelMinSize = 60.0;
    final double _panelMaxSize = MediaQuery.of(context).size.height / 1.5;
    return Scaffold(
      body: WeSlide(
        controller: WeSlideController(),
        panelMinSize: _panelMinSize,
        panelMaxSize: _panelMaxSize,
        body: HomeScreen(),
        panel: Scaffold(
          resizeToAvoidBottomInset: false,
          body: StreamBuilder(
            stream: firestoreDb,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, int index) {
                  return EditActivityTest(
                    index: index,
                    snapshot: snapshot.data,
                  );
                },
              );
            },
          ),
        ),
        panelHeader: Container(
          alignment: Alignment.center,
          child: Text(
            'Edit activity',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          color: Colors.blue,
          height: _panelMinSize,
        ),
        blurSigma: 0.75,
        blur: true,
        parallax: true,
        bodyBorderRadiusBegin: 20,
        panelBorderRadiusEnd: 20,
        parallaxOffset: 0,
        overlayOpacity: 10,
        hidePanelHeader: false,
      ),
    );
  }
}

class EditActivityTest extends StatefulWidget {
  final QuerySnapshot snapshot;
  final int index;

  const EditActivityTest({Key key, this.snapshot, this.index})
      : super(key: key);
  @override
  _EditActivityTestState createState() => _EditActivityTestState();
}

class _EditActivityTestState extends State<EditActivityTest> {
  String _setTime, _setDate;
  String _hour, _minute, _time;
  String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _dateController;
  TextEditingController _timeController;
  TextEditingController nameInputController;
  TextEditingController iconInputController;
  TextEditingController colorInputController;

  Future<Null> _selectedDate(BuildContext context) async {
    var selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2021),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  Future<Null> _selectedTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ':' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2021, 03, 16, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, ' ', am]).toString();
      });
    }
  }

  void initState() {
    super.initState();
    //iconInputController = new TextEditingController();
    //nameInputController = new TextEditingController();
    //categoryInputController = new TextEditingController();
    //iconInputController = new TextEditingController();
    //colorInputController = new TextEditingController();
    //_dateController = new TextEditingController();
    //_timeController = new TextEditingController();
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _timeController.text = formatDate(
        DateTime(2021, 03, 16, selectedTime.hour, selectedTime.minute),
        [hh, ':', nn, ' ', am]).toString();
  }

  String initalValue = 'icon';
  DateTime dt = new DateTime.now();
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
  final firebaseDB = FirebaseFirestore.instance.collection('test').snapshots();
  @override
  Widget build(BuildContext context) {
    var snapshotName = widget.snapshot.docs[widget.index].get('name');
    var snapshotIkona = widget.snapshot.docs[widget.index].get('ikona');
    var snapshotBarva = widget.snapshot.docs[widget.index].get('barva');
    var snapshotDate = widget.snapshot.docs[widget.index].get('date');
    var snapshotTime = widget.snapshot.docs[widget.index].get('time');
    var docID = widget.snapshot.docs[widget.index].id;
    TextEditingController nameInputController =
        TextEditingController(text: snapshotName);
    TextEditingController iconInputController =
        TextEditingController(text: snapshotIkona);
    TextEditingController colorInputController =
        TextEditingController(text: snapshotBarva);
    TextEditingController _dateController =
        TextEditingController(text: snapshotDate);
    TextEditingController _timeController =
        TextEditingController(text: snapshotTime);
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: TextField(
              autofocus: true,
              autocorrect: true,
              maxLines: 1,
              decoration: InputDecoration(
                helperText: 'Enter a name of a activity',
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
          Column(
            children: [
              Text(
                'Choose date',
              ),
              InkWell(
                onTap: () {
                  _selectedDate(context);
                },
                child: Container(
                  child: TextFormField(
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                    onSaved: (String val) {
                      _setDate = val;
                    },
                    enabled: false,
                    controller: _dateController,
                    decoration: InputDecoration(
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ),
              Text(
                'Choose time',
              ),
              InkWell(
                onTap: () {
                  _selectedTime(context);
                },
                child: Container(
                  child: TextFormField(
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                    onSaved: (String val) {
                      _setTime = val;
                    },
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _timeController,
                    decoration: InputDecoration(
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              )
            ],
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
                  if (nameInputController.text.isNotEmpty &&
                      iconInputController.text.isNotEmpty &&
                      _dateController.text.isNotEmpty &&
                      colorInputController.text.isNotEmpty &&
                      _timeController.text.isNotEmpty) {
                    debugPrint('EDITNUTO');
                    FirebaseFirestore.instance
                        .collection('test')
                        .doc(docID)
                        .update({
                      'name': nameInputController.text,
                      'ikona': iconInputController.text,
                      'date': _dateController.text,
                      'barva': colorInputController.text,
                      'time': _timeController.text,
                      'timestamp': dt,
                    }).then((response) {
                      Navigator.pop(context);
                    });
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
                      _dateController.text.isNotEmpty &&
                      _timeController.text.isNotEmpty &&
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
                                      builder: (builder) => HomeScreen()));
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
                  _dateController.clear();
                  _timeController.clear();
                  colorInputController.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
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
