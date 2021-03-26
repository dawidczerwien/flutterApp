import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class NotesHomePage extends StatefulWidget {
  @override
  _NotesHomePage createState() => _NotesHomePage();
}

class _NotesHomePage extends State<NotesHomePage> {
  int _counter = 0;
  Query _ref;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('Notatki')
        .orderByChild('time');
  }

  Widget _buildContactItem({Map notes}) {
    return Container(
        padding: EdgeInsets.only(top: 35, left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              notes['title'],
              style: TextStyle(fontSize: 22),
            ),
            Text(
              notes['time'].split(' ')[0],
              style: TextStyle(fontSize: 15),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: FirebaseAnimatedList(
              query: _ref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map notes = snapshot.value;
                return _buildContactItem(notes: notes);
              })),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
