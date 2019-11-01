import 'package:alarm_first_app/helpers/DBHelper.dart';
import 'package:alarm_first_app/models/Schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:sqflite/sqflite.dart';

class ScheduleForm extends StatefulWidget {
  final VoidCallback onUpdateList;
  final Schedule schedule;
  final String title;
  ScheduleForm({this.onUpdateList, this.schedule, this.title});
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<ScheduleForm> {
  DateTime timeStamp = DateTime.now();

  Future<void> createOrUpdateSchedule(Schedule schedule) async {
    DBHelper database =
        DBHelper(dbName: Schedule.dbName, createQuery: Schedule.onCreateQuery);
    final Database db = await database.db;
    if (schedule != null) {
      db.insert(Schedule.tableName, schedule.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
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
          title: Text(widget.title),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                TimeOfDay time = TimeOfDay.fromDateTime(timeStamp);
                Schedule schedule;
                if (widget.schedule == null) {
                  schedule = Schedule(
                      id: timeStamp.microsecondsSinceEpoch,
                      time: time,
                      isOn: 1,
                      isDelete: 0);
                } else {
                  schedule = Schedule(
                      id: widget.schedule.id,
                      time: time,
                      isOn: widget.schedule.isOn,
                      isDelete: widget.schedule.isDelete);
                }
                await createOrUpdateSchedule(schedule);

                widget.onUpdateList();
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Container(
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: widget.schedule == null
                ? timeStamp
                : DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                    widget.schedule.time.hour,
                    widget.schedule.time.minute
                    ),
            onDateTimeChanged: (DateTime time) {
              setState(() {
                timeStamp = time;
              });
            },
          ),
        ));
  }
}
