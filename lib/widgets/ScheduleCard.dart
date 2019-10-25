import 'package:alarm_first_app/helpers/DBHelper.dart';
import 'package:alarm_first_app/models/Schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqlite_api.dart';

class ScheduleCard extends StatefulWidget {
  final Schedule schedule;

  ScheduleCard(this.schedule);

  @override
  State<StatefulWidget> createState() => _ScheduleCardState(schedule);
}

class _ScheduleCardState extends State<ScheduleCard> {
  Schedule schedule;
  _ScheduleCardState(this.schedule);

  _onChangeAlarmStatus(bool value) async {
    int isOn;
    if (value == true) {
      isOn = 1;
    } else {
      isOn = 0;
    }
    setState(() {
      schedule.isOn = isOn;
    });
    await updateOnOffAlarm(schedule);
  }

  Future<void> updateOnOffAlarm(Schedule schedule) async {
    DBHelper database =
        DBHelper(dbName: Schedule.dbName, createQuery: Schedule.onCreateQuery);
    final Database db = await database.db;
    if (schedule != null) {
      db.update(Schedule.tableName, schedule.toMap(), where: "id = ?", whereArgs: [schedule.id]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[timeText, alarmSwitch],
      ),
    );
  }

  Widget get timeText {
    return Text(schedule.time.format(context));
  }

  Widget get alarmSwitch {
    return CupertinoSwitch(
        value: schedule.isOn == 1,
        onChanged: (bool value) => _onChangeAlarmStatus(value));
  }
}
