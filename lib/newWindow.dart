import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class NewScreen extends StatefulWidget {
  final FirebaseApp app;
  NewScreen({this.app});

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final referenceDatabase = FirebaseDatabase.instance;
  DateTime _chosenDateTime = DateTime.now();
  var img;
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        _image = null;
        print('No image selected.');
      }
    });
  }

  Future uploadPic() async {
    if (_image == null) {
      return null;
    }
    String fileName = basename(_image.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await firebaseStorageRef.getDownloadURL();
    setState(() {
      print("Profile Picture uploaded: $url");
    });
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();
    return Scaffold(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    getImage();
                  },
                  icon: Icon(Icons.photo_library)),
              CircleAvatar(
                radius: 90,
                backgroundColor: Color(0xFF243B55),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          _image,
                          width: 170,
                          height: 170,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(100)),
                        width: 170,
                        height: 170,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              )
            ],
          ),
          new Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
                onPressed: () {
                  uploadPic().then((value) {
                    ref.child("Notatki").push().set({
                      'title': myController.text,
                      'time': _chosenDateTime.toString(),
                      'image': value
                    });
                    myController.text = '';
                  });
                },
                child: Text('Save to firebase')),
          )
        ],
      ),
    ));
  }
}
