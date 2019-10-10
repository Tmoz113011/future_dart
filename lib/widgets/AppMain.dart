import 'package:flutter/material.dart';
import 'package:alarm_first_app/widgets/HomePage.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarm App',
      theme: ThemeData(
        primarySwatch: Colors.greenAccent[50],
      ),
      home: MyHomePage(title: 'Alarm App'),
    );
  }
}
