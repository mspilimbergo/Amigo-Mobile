import 'package:flutter/material.dart';
import '../widgets/TagButton.dart';
import './Data/tag_object.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;
import 'dart:math';

//String img = "https://media-exp1.licdn.com/dms/image/C560BAQG4QXbbg39AfQ/company-logo_100_100/0?e=2159024400&v=beta&t=QYCFMlTBClczprYLrvWL1W4sbCrWw0TmGfuUTapBmDY";
String randimg = "https://source.unsplash.com/random";
final storage = FlutterSecureStorage();
final SERVER_URL = "http://10.0.2.2:3000";

class DiscoverTagView extends StatefulWidget {
  @override
  _DiscoverTagViewState createState() => _DiscoverTagViewState();
}

class _DiscoverTagViewState extends State<DiscoverTagView> {
  String searchQuery;
  var popularTags;
  var allTags;
  int tagCount = 0;
  var rng = new Random();

  void getTags() async {
    var key = await storage.read(key: "jwt");
    var res = await http.get(
      "$SERVER_URL/api/tags",
      headers: {"x-access-token": key},
    );
    if (res.statusCode == 200) {
      Map response = json.decode(res.body);
      setState(() {
        allTags = Tag.fromJson(response).tags;
        print('all tags: ' + allTags);
        tagCount = allTags.length;
        print(allTags[0].name);
      });
    } else
      print(res.body.toString());
  }

  Widget searchMode() {
    if (searchQuery.isEmpty) {
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getTags();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: <Widget>[
        //       Container(
        //         margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
        //         child: Text("Whatfre f your interests?",
        //             style: TextStyle(color: Colors.red, fontSize: 22),
        //             textAlign: TextAlign.left,
        //             ),

        //       )
        //     ],
        //   ),
        //   // centerTitle: true,
        // ),
        body: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: TextField(
                      obscureText: false,
                      enableInteractiveSelection: true,
                      onChanged: (string) {
                        setState(() {
                          searchQuery = string;
                          print(searchQuery);
                        });
                      },
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
                        TextSpan(
                            text: "University of Central Florida",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ])),
                ),
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
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: TagButton(
                                          tagID: index.toString(),
                                          name: "BasketballBasket",
                                          photo: "https://i.picsum.photos/id/${rng.nextInt(300)}/200/200.jpg"),
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 0,
                              childAspectRatio: .95,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: TagButton(
                                      tagID: allTags[index].tagId,
                                      name: allTags[index].name,
                                      photo: "https://i.picsum.photos/id/${rng.nextInt(500)}/200/200.jpg"),
                                );
                              },
                              childCount: tagCount,
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
