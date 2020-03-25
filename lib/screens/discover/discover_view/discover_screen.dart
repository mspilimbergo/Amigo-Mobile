import 'package:flutter/material.dart';
import '../discover_response/discover_response_screen.dart';


class DiscoverScreen extends StatelessWidget {
  //https request to get all of the channels associated with a tag
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          child: Text('Navigate to Channel View'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DiscoverResponseScreen(tagSelected: 'Sports',))
            );
          },
        )
      )
    );
  }

}