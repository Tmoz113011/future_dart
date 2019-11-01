import 'dart:convert';
import 'dart:typed_data';
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
  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  List<Schedule> schedules = [];

  @override
  void initState() {
    super.initState();
    setListAlarm();
  }

  void _onOpenCreateForm() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ScheduleForm(
                  onUpdateList: this.setListAlarm,
                  title: 'Create Form',
                )));
  }

  void setListAlarm() async {
    List<Schedule> _schedules = await getListSchedule();
    setState(() {
      schedules = _schedules;
    });
    setUpNotification();
  }

  Future _onSelectNotification(String payload) async {
    // TODO: Implement later
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => MyHomePage(title: "home",)));
  }

  setUpNotification() {
    // docs: https://medium.com/@nitishk72/flutter-local-notification-1e43a353877b
    AndroidInitializationSettings androidInitializationSettings =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings iosInitializationSettings =
        new IOSInitializationSettings();
    InitializationSettings initializationSettings = new InitializationSettings(
      androidInitializationSettings,
      iosInitializationSettings,
    );
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
    _showNotificationWithDefaultSound(
        flutterLocalNotificationsPlugin, schedules);
  }

  Future _showNotificationWithDefaultSound(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      List<Schedule> schedules) async {
    var vibrationPattern = new Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;
    int id = 1;
    schedules.forEach((schedule) {
      if (schedule.isOn == 1) {
        id++;
        AndroidNotificationDetails androidNotificationDetails =
            new AndroidNotificationDetails(
          "${schedule.id}",
          "${schedule.time.format(context)}",
          "Wake!! ${schedule.time.format(context)}",
          icon: '@mipmap/ic_launcher',
          vibrationPattern: vibrationPattern,
        );

        IOSNotificationDetails iosNotificationDetails =
            new IOSNotificationDetails();
        NotificationDetails notificationDetails = NotificationDetails(
            androidNotificationDetails, iosNotificationDetails);

        DateTime scheduleTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            schedule.time.hour,
            schedule.time.minute);

            // flutterLocalNotificationsPlugin.show(id, 'Wake Up!',  "Wake!! ${schedule.time.format(context)}", notificationDetails);
        flutterLocalNotificationsPlugin.schedule(
            id,
            'Wake Up!',
            "Wake!! ${schedule.time.format(context)}",
            scheduleTime,
            notificationDetails,
            androidAllowWhileIdle: true);
      }
    });
  }

  Future<List<Schedule>> getListSchedule() async {
    // Construct ref database
    final Database db = await new DBHelper(
            dbName: Schedule.dbName, createQuery: Schedule.onCreateQuery)
        .db;

    //Get all data
    final List<Map<String, dynamic>> maps =
        await db.query(Schedule.tableName, where: "isDelete = 0");

    //Maping data
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
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child:
            ListSchedule(schedules: schedules, onUpdateList: this.setListAlarm),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onOpenCreateForm,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
