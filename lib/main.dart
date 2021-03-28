import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'newWindow.dart';
import 'calendarView.dart';
import 'notesBottomBar.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calendar',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    CalendarView(),
    NotesHomePage(),
  ];
  @override
  void initState() {
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My Calendar'),
          backgroundColor: Color(0xFF243B55),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => NewScreen()));
                      print("add");
                    },
                    child: new Container(
                        width: 50,
                        decoration: new BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add_box,
                          size: 46.0,
                        )))),
          ]),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.white,
        backgroundColor: Color(0xFF141E30),
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Kalendarz',
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.article_rounded,
            ),
            label: 'Notatki',
          ),
        ],
      ),
    );
  }
}
