import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amigo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Amigo'),
        ),
        body: Center(
          child: Text('Welcome to Amigo'),
        ),
      ),
    );
  }
}