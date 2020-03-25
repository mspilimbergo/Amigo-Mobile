import 'package:flutter/material.dart';
import '../../../classes/channel.class.dart';
import './Data/channelList_data.dart';
import '../widgets/ChannelCard.dart';

//Todo: 
// Add 'Here's what we found' title
// Discover View: Add Search bar
// Implement getChannelsFromTag
// Style Page appropriately 
class DiscoverResponseScreen extends StatelessWidget {

  final String tagSelected;
  
  DiscoverResponseScreen({Key key, @required this.tagSelected}) : super(key:key);
  // Todo: implement getChannelsFromTagID using tageSelected
  
  //List of channels response from getChannelsFromTag
  final List<Channel> channelList = ChannelListData.getChannelList();

  @override 
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: Text('Channel View'),
      ),
      body: Container(
      child: new ListView.builder(
        itemCount: channelList.length,
        itemBuilder: (BuildContext context, int index) {
          return ChannelCard(
            '123',
            'Ghana Soccer Group', 
            'This is some description of the channel... This text is a temporary placeholder and it is only being used for display purposes',
            18,
            'https://cdn2.iconfinder.com/data/icons/activity-5/50/1F3C0-basketball-512.png'
            );
        }

      )
    )
    );
  }
}

