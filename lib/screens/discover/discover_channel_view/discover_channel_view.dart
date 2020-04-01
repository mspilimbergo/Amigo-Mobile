import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../../classes/channel.class.dart';
import './Data/channelList_data.dart';
import '../widgets/ChannelCard.dart';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


String randimg = "https://source.unsplash.com/random";
final storage = FlutterSecureStorage();
final SERVER_URL = "http://10.0.2.2:3000";

class DiscoverChannelView extends StatelessWidget {

  final String tagSelected;
  
  DiscoverChannelView({Key key, @required this.tagSelected}) : super(key:key);
  
  final List<Channel> channelList = ChannelListData.getChannelList();

  Future<List<Channel>> getChannels () async {
    log(tagSelected);
    // var key = await storage.read(key: "jwt");
    // Response res = await http.get(
    //   "$SERVER_URL/api/channels/?tag_id=$tagSelected",
    //   headers: {"x-access-token": key},
    // );
  }

  @override 
  Widget build(BuildContext context) { 
    getChannels();
    log(tagSelected);
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
          child: Column(children: <Widget>[
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
                      child:Text('We recommend',textAlign: TextAlign.start,style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
                    )
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                      if (index == 5 ) return null;
                      if (channelList[index].memberCount == 18) {
                        return ChannelCard(
                      "123",
                      'Recommended Group', 
                      'This is some description of the channel... This text is a temporary placeholder and it is only being used for display purposes and this extra text is to show how it handles overflow',
                      18,
                      'https://cdn2.iconfinder.com/data/icons/activity-5/50/1F3C0-basketball-512.png'
                      );
                      }
                      }
                    ) ),
                    SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child:Text('All',textAlign: TextAlign.start,style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
                    )
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                      if (index == 5) return null;
                        return ChannelCard(
                      '101',
                      'Ghana Soccer Group', 
                      'some description of the channel... This text is a temporary placeholder and it is only being used for display purposes and this extra text is to show how it handles overflow',
                      18,
                      'https://cdn2.iconfinder.com/data/icons/activity-5/50/1F3C0-basketball-512.png'
                      );

                      }
                    ) ),
                ],
              ),
            )
          ],
          ),
    ),  
    );
  }
}


// ![CustomScrollView]
//   ![SliverToBoxAdapter]
//     "We Recommend"
//   ![SliverList]
//     ![SliverChildBuilderDelegate]
//       Build Your Widget Here
//   SliverToBoxAdapter
//     "All"
//   SliverList
//     SliverChildBuilderDelegate
       