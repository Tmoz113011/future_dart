import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({this.title});

  final Widget title;

  @override
  Widget build(BuildContext build) {
    return Container(
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_before),
            onPressed: () => {
              //TODO: Implement later when learning navigate
            },
          ),
          Expanded(
            child: title,
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: null,
          )
        ],
      ),
    );
  }
}
