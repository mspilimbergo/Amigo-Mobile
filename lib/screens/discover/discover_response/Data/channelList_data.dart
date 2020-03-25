import '../../../../classes/channel.class.dart';

class ChannelListData {
  static List<Channel> getChannelList() {
    return List.generate(
      20,
      (i) => Channel(
      '123', 
      'Ghana Soccer @ UCF', 
      'This is a sample description that doesnt actually describe the channel shown above so ignore this',
      18,
      'Orlando, Fl',
      'https://cdn2.iconfinder.com/data/icons/activity-5/50/1F3C0-basketball-512.png',
      '09/30/2019'
    ));
  }
}