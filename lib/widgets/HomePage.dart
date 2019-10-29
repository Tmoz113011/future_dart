import 'dart:convert';
import 'package:alarm_first_app/helpers/DBHelper.dart';
import 'package:alarm_first_app/models/Schedule.dart';
import 'package:alarm_first_app/widgets/CreateForm.dart';
import 'package:alarm_first_app/widgets/ListSchedule.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Schedule> schedules = [];
  final FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();
  
  @override
  void initState() {
    super.initState();
    setListAlarm();
    setUpNotification();
  }

  void _onOpenCreateForm() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ScheduleForm(onUpdateList: this.setListAlarm, title: 'Create Form',)));
  }

  void setListAlarm() async {
    List<Schedule> _schedules = await getListSchedule();
    setState(()  {
      schedules = _schedules;
    });
  }

  setUpNotification() {

  }

  Future<List<Schedule>> getListSchedule() async {
    // Construct ref database
    final Database db = await new DBHelper(
            dbName: Schedule.dbName, createQuery: Schedule.onCreateQuery)
        .db;

    //Get all data
    final List<Map<String, dynamic>> maps = await db.query(Schedule.tableName);
    if (maps != null && maps != []) {
      return List.generate(maps.length, (key) {
        var time = jsonDecode(maps[key]['time']);
        TimeOfDay timeStamp =
            TimeOfDay(hour: time['hour'], minute: time['minute']);
        return Schedule(
            id: maps[key]['id'],
            time: timeStamp,
            isOn: maps[key]['isOn'],
            isDelete: maps[key]['isDelete']);
      });
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.greenAccent[50],
      ),
      body: Center(
        child: ListSchedule(schedules:schedules, onUpdateList: this.setListAlarm),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onOpenCreateForm,
        child: Icon(Icons.add),
        backgroundColor: Colors.greenAccent[50],
      ),
    );
  }
}
