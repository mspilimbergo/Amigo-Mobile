import 'package:flutter/material.dart';
import './widgets/TagButton.dart';

//String img = "https://media-exp1.licdn.com/dms/image/C560BAQG4QXbbg39AfQ/company-logo_100_100/0?e=2159024400&v=beta&t=QYCFMlTBClczprYLrvWL1W4sbCrWw0TmGfuUTapBmDY";
String randimg = "https://source.unsplash.com/random";

class DiscoverTagView extends StatefulWidget {
  @override
  _DiscoverTagViewState createState() => _DiscoverTagViewState();
}

class _DiscoverTagViewState extends State<DiscoverTagView> {
  String searchTag;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text("What are your interests?",
                    style: TextStyle(color: Colors.red, fontSize: 22)),
              )
            ],
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
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
              margin: EdgeInsets.fromLTRB(20, 1, 0, 10),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.body1,
                      children: [
                    WidgetSpan(child: Icon(Icons.pin_drop, size: 20)),
                    TextSpan(text: "University of Central Florida"),
                  ])),
            ),
            // Container(
            //     child: Center(
            //         child: RaisedButton(
            //   child: Text('Navigate to Channel View'),
            //   onPressed: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => DiscoverChannelView(
            //                 tagSelected: 'Sports',
            //               )));
            // },
            // ))),
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
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child:
                                      TagButton("$index", "Basketball", randimg),
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
                          crossAxisCount: 3,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 0,
                          childAspectRatio: .95,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: TagButton("$index", "Basketball", randimg),
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
        ));
  }
}
