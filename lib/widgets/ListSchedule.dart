import 'package:alarm_first_app/helpers/DBHelper.dart';
import 'package:alarm_first_app/models/Schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'ScheduleCard.dart';

class ListSchedule extends StatelessWidget {
  final List<Schedule> schedules;
  final VoidCallback onUpdateList;
  ListSchedule({this.schedules, this.onUpdateList});

  Future<void> _onDeleteAlarm(Schedule schedule) async {
    final Database db = await DBHelper(
            dbName: Schedule.dbName, createQuery: Schedule.onCreateQuery)
        .db;

    db.update(Schedule.tableName, schedule.toMap(),
        where: "id = ?", whereArgs: [schedule.id]);
    this.onUpdateList();
  }

  ListView _listAlarms(context) {
    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, i) {
        final item = schedules[i].id.toString();
        return Dismissible(
          onDismissed: (direction) {
            Schedule schedule = Schedule(
              id: schedules[i].id,
              time: schedules[i].time,
              isOn: schedules[i].isOn,
              isDelete: 1
            );
             _onDeleteAlarm(schedule);
          },
          key: Key(item),
          child: ScheduleCard(
              schedule: schedules[i], onUpdateList: this.onUpdateList),
          background: Container(
            color: Colors.red,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _listAlarms(context);
  }
}
