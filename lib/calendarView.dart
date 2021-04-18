import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarView createState() => _CalendarView();
}

class _CalendarView extends State<CalendarView> {
  CalendarController _controller;

  Map<DateTime, List> mapFetch = {};

  void getData() {
    final firebaseUser = Provider.of<User>(context, listen: false);
    var db = FirebaseDatabase.instance.reference().child(firebaseUser.uid);
    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        DateTime date = new DateTime(
            DateTime.parse(values["time"]).year,
            DateTime.parse(values["time"]).month,
            DateTime.parse(values["time"]).day);
        if (mapFetch[date] != null) {
          mapFetch[date].add(values["title"]);
        } else {
          mapFetch[date] = [values["title"]];
        }
      });
    });
  }

  @override
  void initState() {
    getData();
    _controller = CalendarController();
    super.initState();
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.indigoAccent,
      ),
      width: 26.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF243B55),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
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
                child: TableCalendar(
                  locale: 'pl_PL',
                  events: mapFetch,
                  builders: CalendarBuilders(
                    markersBuilder: (context, date, events, holidays) {
                      final children = <Widget>[];

                      if (events.isNotEmpty) {
                        children.add(
                          Positioned(
                            right: 4,
                            bottom: 15,
                            child: _buildEventsMarker(date, events),
                          ),
                        );
                      }

                      return children;
                    },
                    dayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        alignment: Alignment.center,
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                    todayDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  rowHeight: 95,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    centerHeaderTitle: true,
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarController: _controller,
                )),
          ],
        ),
      ),
    );
  }
}
