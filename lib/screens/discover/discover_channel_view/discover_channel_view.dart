import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../../classes/channel.dart';
import '../widgets/ChannelCard.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


final storage = FlutterSecureStorage();
final SERVER_URL = "https://amigo-269801.appspot.com";

class DiscoverChannelView extends StatefulWidget {
  final String tagSelected;

  const DiscoverChannelView ({Key key, @required this.tagSelected}) : super(key:key);

  @override
  _DiscoverChannelViewState createState() => _DiscoverChannelViewState();
}


class _DiscoverChannelViewState extends State<DiscoverChannelView> {
  List<Channel> channels;

  void getChannels () async {
    var key = await storage.read(key: "jwt");
    String tagSelected = widget.tagSelected;
    print(tagSelected);
    Response res = await http.get(
      "$SERVER_URL/api/channels/?tag_id=$tagSelected",
      headers: {"x-access-token": key},
    );
    if (res.statusCode == 200) {
      // Deserialize JSON into a map
      Map response = jsonDecode(res.body);
      
      // Store JSON array of channels into a List
      List jsonChannels = response["channels"] as List;

      setState(() {
        // Iterate through JSON array of channels and turn list into array of Channels
        channels = jsonChannels.map<Channel>((channel) => Channel.fromJson(channel)).toList();        
      });
    }
    else {
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
    getChannels();
  }

  @override 
  Widget build(BuildContext context) { 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.red),
        title: Container(
          child: Row(children: <Widget>[
            Text(
            'Here\'s what we found',
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.w400),
          ),
          ],)
        ),
        
      ),
      body: Container(
          // decoration: BoxDecoration(color: Theme.of(context).accentColor),
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[              
            Container(
              height: 50,
                child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0))
                  ),
                  labelText: 'Try "Pickup Soccer'
                ),
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child:Text('We recommend',textAlign: TextAlign.start, style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
                    )
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                        return ChannelCard(
                          channels[index].channelId,
                          channels[index].name,
                          channels[index].description,
                          12,
                          'https://cdn2.iconfinder.com/data/icons/activity-5/50/1F3C0-basketball-512.png'
                        );
                    }
                    ) ),
                  //   SliverToBoxAdapter(
                  //   child: Container(
                  //     margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  //     child:Text('All',textAlign: TextAlign.start,style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
                  //   )
                  // ),
                  // SliverList(
                  //   delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                      // if (index == 5 ) {
                      //   return null;
                      // }
                      // if (true) {
                      //   return ChannelCard(
                      //     channels[index].channelId,
                      //     channels[index].name,
                      //     channels[index].description,
                      //     12,
                      //     'https://cdn2.iconfinder.com/data/icons/activity-5/50/1F3C0-basketball-512.png'
                      //   );
                      // }
                    // }
                    // ) ),
                ],
              ),
            )
          ],
          ),
    ),  
    );
  }
}

       