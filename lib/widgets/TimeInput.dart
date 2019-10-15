import 'package:flutter/material.dart';
class TimeInput extends StatefulWidget {
  TimeInput({Key key}) : super(key: key);

  @override
  _TimeInputState createState() => new _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new IconButton(
            icon: new Icon(Icons.keyboard_arrow_up, size: 30.0),
            onPressed: null,
          ),
          new Text("$_value", style: new TextStyle(fontSize: 30.0)),
          new IconButton(
            onPressed: null,
            icon: new Icon(Icons.keyboard_arrow_down, size: 30.0),
          )
        ],
      ),
    );
  }
}
