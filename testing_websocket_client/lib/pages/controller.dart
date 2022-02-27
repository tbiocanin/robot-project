import 'package:flutter/material.dart';

class Controller extends StatefulWidget {
  const Controller({Key ? key, required this.title}) : super(key : key);

  final String title;

  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {

  @override 
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      
    );
  }
}