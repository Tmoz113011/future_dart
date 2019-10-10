import 'package:flutter/material.dart';
import 'package:alarm_first_app/widgets/commons/AppBar.dart';

class MyScafford extends StatelessWidget {
  @override
  Widget build(BuildContext build) {
    return Material(
      child: Column(
        children: <Widget>[
          CustomAppBar(title: Text('Home')),
          Expanded(
            child: Center(
              child: Text("Test Scafford"),
            ),
          )
        ],
      ),
    );
  }
}
