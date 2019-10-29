import 'package:alarm_first_app/helpers/DBHelper.dart';
import 'package:alarm_first_app/models/Schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqlite_api.dart';

class ScheduleCard extends StatefulWidget {
  final Schedule schedule;

  const ScheduleCard({Key key, this.schedule}) : super(key: key);

  @override
  _ScheduleCardState createState() => _ScheduleCardState(schedule);
}

class _ScheduleCardState extends State<ScheduleCard> {
  Schedule schedule;
  _ScheduleCardState(this.schedule);

  void _onChangeAlarmStatus(bool value) async {
    int isOn;
    if (value == true) {
      isOn = 1;
    } else {
      isOn = 0;
    }
    schedule.isOn = isOn;
    final Database db = await DBHelper(
            dbName: Schedule.dbName, createQuery: Schedule.onCreateQuery)
        .db;

    db.update(Schedule.tableName, schedule.toMap(),
        where: "id = ?", whereArgs: [schedule.id]);
    setState(() {
      schedule = schedule;
    });
  }

  Future<void> updateOnOffAlarm(Schedule _schedule) async {
    DBHelper database =
        DBHelper(dbName: Schedule.dbName, createQuery: Schedule.onCreateQuery);
    final Database db = await database.db;
    if (_schedule != null) {
      db.update(Schedule.tableName, _schedule.toMap(),
          where: "id = ?", whereArgs: [_schedule.id]);
      setState(() {
        schedule = _schedule;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: null,
      child: Container(
        constraints: BoxConstraints.expand(height: 60),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)))),
        padding: EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[timeText, alarmSwitch],
        ),
      ),
    );
  }

  Widget get timeText {
    return Text(
      schedule.time.format(context),
      style: TextStyle(
        fontFamily: 'Digital',
        fontSize: 30
      ),
      );
  }

  Widget get alarmSwitch {
    return CupertinoSwitch(
        value: schedule.isOn == 1,
        onChanged: (bool value) async => _onChangeAlarmStatus(value));
  }
}
