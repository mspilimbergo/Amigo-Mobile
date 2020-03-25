import 'package:flutter/material.dart';
import '../discover/discover_channel_view/discover_channel_view.dart';

String img =
    "https://media-exp1.licdn.com/dms/image/C560BAQG4QXbbg39AfQ/company-logo_100_100/0?e=2159024400&v=beta&t=QYCFMlTBClczprYLrvWL1W4sbCrWw0TmGfuUTapBmDY";

class TagButton extends StatelessWidget {
  final int tagID;
  final String name;

  TagButton(this.tagID, this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Container(
        height: 125,
        width: 125,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      Text("Basketball", style: TextStyle(fontSize: 16)),
    ]));
  }
}

class DiscoverTagView extends StatefulWidget {
  @override
  _DiscoverTagViewState createState() => _DiscoverTagViewState();
}

class _DiscoverTagViewState extends State<DiscoverTagView> {
  String searchTag;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text("What are your interests?",
                    style: TextStyle(color: Colors.red, fontSize: 22))),
            Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                  ),
                )),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.body1,
                      children: [
                    WidgetSpan(child: Icon(Icons.pin_drop, size: 20)),
                    TextSpan(text: "Orlando"),
                  ])),
            ),
            Container(
                child: Center(
                    child: RaisedButton(
              child: Text('Navigate to Channel View'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DiscoverChannelView(
                              tagSelected: 'Sports',
                            )));
              },
            ))),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Expanded(
                      child: CustomScrollView(slivers: <Widget>[
                    SliverToBoxAdapter(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: Text("Popular Now",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)))),
                    SliverToBoxAdapter(
                      child: Container(
                          height: 150,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: TagButton(index, "Basketball"),
                                );
                              })),
                    ),
                    SliverToBoxAdapter(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: Text("Categories",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)))),
                    SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 0,
                          childAspectRatio: 1.4,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: TagButton(index, "Basketball"),
                            );
                          },
                          childCount: 20,
                        )),
                  ]))
                ])),
            Container(
                child: Column(
              children: <Widget>[],
            ))
          ]),
    );
  }
}
