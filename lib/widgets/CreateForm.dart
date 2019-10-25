import 'package:alarm_first_app/helpers/DBHelper.dart';
import 'package:alarm_first_app/models/Schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:sqflite/sqflite.dart';

class ScheduleForm extends StatefulWidget {
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<ScheduleForm> {
  DateTime timeStamp = DateTime.now(); 

  Future<void> createSchedule(Schedule schedule) async {
    DBHelper database =
        DBHelper(dbName: Schedule.dbName, createQuery: Schedule.onCreateQuery);
    final Database db = await database.db;
    if (schedule != null) {
      db.insert(Schedule.tableName, schedule.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Add Alarm'),
          backgroundColor: Colors.orangeAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                Schedule schedule = Schedule(id: timeStamp.microsecondsSinceEpoch, time: TimeOfDay(hour: timeStamp.hour, minute: timeStamp.minute), isOn: 1, isDelete: 0);
                await createSchedule(schedule);
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Container(
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: timeStamp,
            onDateTimeChanged: (DateTime time) {
              setState(() {
                timeStamp = time;
              });
            }, 
          ),
        ));
  }
}
