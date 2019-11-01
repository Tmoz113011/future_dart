import 'package:alarm_first_app/helpers/DBHelper.dart';
import 'package:alarm_first_app/models/Schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqlite_api.dart';

import 'CreateForm.dart';

class ScheduleCard extends StatefulWidget {
  final Schedule schedule;
  final VoidCallback onUpdateList;

  ScheduleCard({this.schedule, this.onUpdateList});

  @override
  _ScheduleCardState createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  void _onChangeAlarmStatus(bool value) async {
    int isOn;
    if (value == true) {
      isOn = 1;
    } else {
      isOn = 0;
    }
    Schedule schedule = Schedule(
        id: widget.schedule.id,
        time: widget.schedule.time,
        isOn: isOn,
        isDelete: 0);

    final Database db = await DBHelper(
            dbName: Schedule.dbName, createQuery: Schedule.onCreateQuery)
        .db;

    db.update(Schedule.tableName, schedule.toMap(),
        where: "id = ?", whereArgs: [schedule.id]);
    widget.onUpdateList();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScheduleForm(
                      schedule: widget.schedule,
                      title: "Update alarm",
                      onUpdateList: widget.onUpdateList,
                    ))),
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
        ));
  }

  Widget get timeText {
    return Text(
      widget.schedule.time.format(context),
      style: TextStyle(fontFamily: 'Digital', fontSize: 30),
    );
  }

  Widget get alarmSwitch {
    return Switch(
        activeColor: Colors.greenAccent[50],
        value: widget.schedule.isOn == 1,
        onChanged: (bool value) => _onChangeAlarmStatus(value));
  }
}
