import './screens/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liquorie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage());
  }
}