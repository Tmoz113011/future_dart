import 'package:alarm_first_app/widgets/CreateForm.dart';
import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _onOpenCreateForm() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAlarmFrom()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xFF00E676),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onOpenCreateForm,
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF00E676),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
