import 'package:alarm_first_app/helpers/DBHelper.dart';
import 'package:alarm_first_app/models/Schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'ScheduleCard.dart';

class ListSchedule extends StatefulWidget {
  List<Schedule> schedules;
  final VoidCallback onUpdateList;
  ListSchedule({this.schedules, this.onUpdateList});
  @override
  _ListScheduleState createState() => _ListScheduleState();
}

class _ListScheduleState extends State<ListSchedule> {
  Future<void> _onDeleteAlarm(Schedule schedule) async {
    final Database db = await DBHelper(
            dbName: Schedule.dbName, createQuery: Schedule.onCreateQuery)
        .db;

    db.update(Schedule.tableName, schedule.toMap(),
        where: "id = ?", whereArgs: [schedule.id]);
    widget.onUpdateList();
  }

  ListView _listAlarms(context) {
    return ListView.builder(
      itemCount: widget.schedules.length,
      itemBuilder: (context, i) {
        final item = widget.schedules[i].id.toString();
        return Dismissible(
          onDismissed: (direction) {
            Schedule schedule = Schedule(
                id: widget.schedules[i].id,
                time: widget.schedules[i].time,
                isOn: widget.schedules[i].isOn,
                isDelete: 1);
            _onDeleteAlarm(schedule);
            setState(() {
              widget.schedules.removeAt(i);
            });
          },
          key: Key(item),
          child: ScheduleCard(
              schedule: widget.schedules[i], onUpdateList: widget.onUpdateList),
          background: Container(
            color: Colors.red[200]
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
