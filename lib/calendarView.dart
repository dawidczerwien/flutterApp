import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarView createState() => _CalendarView();
}

class _CalendarView extends State<CalendarView> {
  CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              locale: 'pl_PL',
              builders: CalendarBuilders(
                  todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      ))),
              rowHeight: 100,
              headerStyle: HeaderStyle(formatButtonVisible: false),
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarController: _controller,
            ),
          ],
        ),
      ),
    );
  }
}
