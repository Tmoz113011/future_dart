import 'package:alarm_first_app/helpers/DBHelper.dart';
import 'package:alarm_first_app/models/Schedule.dart';
import 'package:alarm_first_app/widgets/CreateForm.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Schedule> _schedules;

  @override
  void initState() {
    super.initState();
    setDefaultState();
  }

  void _onOpenCreateForm() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ScheduleForm()));
  }

  void setDefaultState() async {
    _schedules = await getListSchedule();
  }

  Future<List<Schedule>> getListSchedule() async {
    // Construct ref database
    final Database db = await new DBHelper(
            dbName: Schedule.dbName, createQuery: Schedule.onCreateQuery)
        .db;

    //Get all data
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM schedules WHERE isDelete=0");
    return List.generate(maps.length, (key) {
      return Schedule(
          id: maps[key]['id'],
          duration: maps[key]['duration'],
          isOn: maps[key]['isOn'],
          isDelete: maps[key]['isDelete']);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_schedules.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.orangeAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onOpenCreateForm,
        child: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}
