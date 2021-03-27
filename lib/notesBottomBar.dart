import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class NotesHomePage extends StatefulWidget {
  @override
  _NotesHomePage createState() => _NotesHomePage();
}

class _NotesHomePage extends State<NotesHomePage> {
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
        decoration: new BoxDecoration(
          border: Border.all(color: Colors.brown, width: 5),
          color: Colors.yellow,
        ),
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.event_note),
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
      backgroundColor: Color(0xFFc42505F),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.2,
              0.8,
            ],
            colors: [
              Color(0xFF141E30),
              Color(0xFF243B55),
            ],
          )),
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
