import 'package:flutter/material.dart';

class HomePage extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Text(
        'Home Page',
        style: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}