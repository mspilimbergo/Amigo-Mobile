import 'dart:convert';
import 'package:amigo_mobile/screens/channel/channel_create.dart';
import 'package:amigo_mobile/screens/discover/discover_channel_view/channel_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../../classes/channel.dart';
import '../widgets/ChannelCard.dart';
import '../../discover/discover_channel_view/channel_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:amigo_mobile/util/colors.dart';
import 'package:path/path.dart';


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
  String searchQuery = "";
  

  Future<List<Channel>> getChannels () async {
    var key = await storage.read(key: "jwt");
    String tagSelected = widget.tagSelected;
    Response res = await http.get(
      "$SERVER_URL/api/channels/?tag_id=$tagSelected&query=$searchQuery",
      headers: {"x-access-token": key},
    );
    if (res.statusCode == 200) {
      // Deserialize JSON into a map
      Map response = jsonDecode(res.body);
      
      // Store JSON array of channels into a List
      List jsonChannels = response["channels"] as List;

      setState(() {
        if (searchQuery == null) {
          searchQuery = "";
        }
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
            style: TextStyle(color: amigoRed, fontSize: 30, fontWeight: FontWeight.bold),
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
              height: 40,
              child: TextField(
              onChanged: (context) {
                setState(() {
                  searchQuery = context;
                  getChannels();
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Try "Pickup Soccer"',
                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20.0),
                contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
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
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: RaisedButton(              
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            settings: RouteSettings(name: "ChannelCreate"),
                            builder: (context) => ChannelCreate() 
                          ) 
                        );
                      },
                      child: Text(
                        'Create New Channel',
                        textAlign: TextAlign.left,), 
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)
                      ),
                      
                      ),
                  ),
                ],
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
                          
                          var channelId =  channels[index].channelId;
                          var name = channels[index].name;
                          var description =channels[index].description;
                          var memberCount = int.parse(channels[index].memberCount);
                          var photo ='https://cdn2.iconfinder.com/data/icons/activity-5/50/1F3C0-basketball-512.png';
                          var createdOn = channels[index].createdOn;
                          
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context, 
                              MaterialPageRoute(
                                settings: RouteSettings(name: "ChannelCard"),
                                builder: (context) => 
                                
                                ChannelPage(
                                  channelId: channelId,
                                  name: name,
                                  description: description,
                                  memberCount: memberCount,
                                  photo: photo,
                                  createdOn: createdOn,
                                  
                                )));
                              print("Card Tapped");
                              },
                            child: ChannelCard(
                                  channelId: channelId,
                                  name: name,
                                  description: description,
                                  memberCount: memberCount,
                                  photo: photo,
                                  createdOn: createdOn,
                            )
                          );
                        })
                    );
                  }
                  else {
                    channelsList = SliverToBoxAdapter(child: 
                    Container(
                      color: Colors.transparent,
                      height: (MediaQuery.of(context).size.height / 4) * 3,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor: new AlwaysStoppedAnimation<Color>(amigoRed)
                        )
                      )
                    ));
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

       