import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreateAlarmForm extends StatelessWidget {
  _handleSaveAlarm() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Add Alarm'),
          backgroundColor: Colors.orangeAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _handleSaveAlarm(),
            )
          ],
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(Icons.keyboard_arrow_up, size: 30.0),
                      onPressed: null,
                    ),
                    new Text("1", style: new TextStyle(fontSize: 30.0)),
                    new IconButton(
                      onPressed: null,
                      icon: new Icon(Icons.keyboard_arrow_down, size: 30.0),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(Icons.keyboard_arrow_up, size: 30.0),
                      onPressed: null,
                    ),
                    new Text("1", style: new TextStyle(fontSize: 30.0)),
                    new IconButton(
                      onPressed: null,
                      icon: new Icon(Icons.keyboard_arrow_down, size: 30.0),
                    )
                  ],
                ),
              ),
              Stack(alignment: AlignmentDirectional.topEnd, children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new IconButton(
                        icon: new Icon(Icons.keyboard_arrow_up, size: 30.0),
                        onPressed: null,
                      ),
                      new Text("1", style: new TextStyle(fontSize: 30.0)),
                      new IconButton(
                        onPressed: null,
                        icon: new Icon(Icons.keyboard_arrow_down, size: 30.0),
                      )
                    ],
                  ),
                ),
                new IconButton(
                  icon: Icon(Icons.alarm),
                  onPressed: () {
                    DatePicker.showTimePicker(context, currentTime: DateTime.now());
                  },
                )
              ]),
            ],
          ),
        ));
  }
}
