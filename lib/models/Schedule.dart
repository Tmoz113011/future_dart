import 'dart:convert';
import 'package:flutter/material.dart';

class Schedule {
  Schedule({this.id, this.time, this.isOn, this.isDelete});

  static final dbName = "schedule.db";
  static final String onCreateQuery =
      "CREATE TABLE schedules(id INTEGER PRIMARY KEY, time TEXT, isOn INTEGER DEFAULT 1, isDelete INTEGER DEFAULT 0)";

  static final tableName = "schedules";

  final int id;
  final int isDelete;
  final int isOn;
  final TimeOfDay time;

  @override
  String toString() {
    return "Schedule($id, $time, $isOn, $isDelete})";
  }

  static Schedule defaultSchedule() {
    TimeOfDay time =
        TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

    return new Schedule(id: 0, time: time, isOn: 1, isDelete: 0);
  }

  set isOn(int value) {
    isOn = value;
  }

  set time(TimeOfDay val) {
    time = val;
  }

  set isDelete(int value) {
    isDelete = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': jsonEncode({'hour': time.hour, 'minute': time.minute}),
      'isOn': isOn,
      'isDelete': isDelete
    };
  }
}
