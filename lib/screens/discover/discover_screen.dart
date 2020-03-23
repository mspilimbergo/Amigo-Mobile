import 'package:flutter/material.dart';

class TagCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Text("My Card"),
      )
    );
  }
}

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TagCard(),
      color: Colors.red,
    );
  }
}