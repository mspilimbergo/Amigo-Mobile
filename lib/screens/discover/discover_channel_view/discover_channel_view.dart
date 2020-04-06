import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../../classes/channel.dart';
import '../widgets/ChannelCard.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:amigo_mobile/util/colors.dart';


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
  var getChannelsData;
  

  Future<List<Channel>> getChannels () async {
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
      return channels;
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
    getChannelsData = getChannels();
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
            'Popular Channels',
            textAlign: TextAlign.start,
            style: TextStyle(color: amigoRed, fontSize: 27, fontWeight: FontWeight.w500),
          ),
          ],)
        ),
        
      ),
      body: Container(
          // decoration: BoxDecoration(color: Theme.of(context).accentColor),
          margin: EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[              
            Container(
              height: 50,
              child: TextField(
              // controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Try "Pickup Soccer"',
                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20.0),
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            ),
            Expanded(
              child: FutureBuilder(
                future: getChannelsData,
                builder: (context, snapshot) {
                  Widget channelsList;
                  if (snapshot.hasData) {
                    channelsList = SliverList(
                        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                          if (index == channels.length) return null;
                          return ChannelCard(
                            channels[index].channelId,
                            channels[index].name,
                            channels[index].description,
                            12,
                            'https://cdn2.iconfinder.com/data/icons/activity-5/50/1F3C0-basketball-512.png'
                          );
                        })
                    );
                  }
                  else {
                    channelsList = SliverToBoxAdapter(child: Container(child: Text('Loading Page'),),);
                  }
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child:Text('We recommend',textAlign: TextAlign.start, style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
                        )
                      ),
                      channelsList                                
                  ],
                );
                }
              )
            )
          ],
          ),
    ),  
    );
  }
}

       