import 'package:flutter/material.dart';
import 'package:alarm_first_app/widgets/HomePage.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarm App',
      theme: ThemeData(
        primarySwatch: Colors.greenAccent[50],
      ),
      home: MyHomePage(title: "Home"),
    );
  }
}
