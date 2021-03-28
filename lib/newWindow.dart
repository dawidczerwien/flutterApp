import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class NewScreen extends StatefulWidget {
  final FirebaseApp app;
  NewScreen({this.app});

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final referenceDatabase = FirebaseDatabase.instance;
  DateTime _chosenDateTime = DateTime.now();

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();

    return Scaffold(
        appBar: AppBar(
          title: Text('Nowa notatka'),
          backgroundColor: Color(0xFF243B55),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Nazwa notatki: ',
                style: TextStyle(fontSize: 25),
              ),
              TextField(
                controller: myController,
                textAlign: TextAlign.center,
              ),
              Container(
                height: 200,
                child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (val) {
                      setState(() {
                        _chosenDateTime = val;
                      });
                    }),
              ),
              TextButton(
                  onPressed: () {
                    ref.child("Notatki").push().set({
                      'title': myController.text,
                      'time': _chosenDateTime.toString()
                    });
                    myController.text = '';
                  },
                  child: Text('Save to firebase')),
            ],
          ),
        ));
  }
}
