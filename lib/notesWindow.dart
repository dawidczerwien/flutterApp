import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

class NotesHomePage extends StatefulWidget {
  @override
  _NotesHomePage createState() => _NotesHomePage();
}

class _NotesHomePage extends State<NotesHomePage> {
  Query _ref;

  @override
  void initState() {
    final firebaseUser = Provider.of<User>(context, listen: false);
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child(firebaseUser.uid)
        .orderByChild('time');
  }

  Widget _buildContactItem({Map notes, var key}) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.event_note),
                IconButton(
                    onPressed: () {
                      final firebaseUser =
                          Provider.of<User>(context, listen: false);
                      FirebaseDatabase.instance
                          .reference()
                          .child(firebaseUser.uid)
                          .child(key)
                          .remove();
                    },
                    icon: Icon(Icons.delete)),
              ],
            ),
            Text(
              notes['title'],
              style: TextStyle(fontSize: 22),
            ),
            Text(
              notes['time'].split(' ')[0],
              style: TextStyle(fontSize: 15),
            ),
            notes['image'] != null ? Image.network(notes['image']) : Text('')
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
                return _buildContactItem(notes: notes, key: snapshot.key);
              })),
    );
  }
}
