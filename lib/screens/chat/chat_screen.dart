import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_socket_io/flutter_socket_io.dart';
// import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

final storage = FlutterSecureStorage();

class ChatPage extends StatefulWidget {
  final String name;
  final String id;

  ChatPage({Key key, @required this.name, @required this.id}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState(name: name, id: id);
}

class _ChatPageState extends State<ChatPage> {
  final String name;
  final String id;
  List<String> messages;
  double height, width;
  SocketIOManager manager;
  TextEditingController textController;
  ScrollController scrollController;
  _ChatPageState({Key key, @required this.name, @required this.id});

  @override
  void initState() {
    manager = SocketIOManager();
    initSocket();
    super.initState();
  }

  initSocket() async {
    //Initializing the message list
    messages = List<String>();
    //Initializing the TextEditingController and ScrollController
    textController = TextEditingController();
    scrollController = ScrollController();
    //Creating the socket
    SocketIOManager manager = SocketIOManager();
    SocketIO socket = await manager.createInstance(SocketOptions(
      //Socket IO server URI
        "https://amigo-269801.appspot.com",
        //Enable or disable platform channel logging
        enableLogging: true,
        transports: [Transports.WEB_SOCKET/*, Transports.POLLING*/] //Enable required transport
    ));
    socket.onConnect((data){
      print("connected...");
      print(data);
      socket.emit('join', [{'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMTgiLCJpYXQiOjE1ODU2NDgyMzYsImV4cCI6MTU4NjI1MzAzNn0.5fPzBzlkPu33pG5sS2W66d7CSjz0hefS_9J-gfkXslM', 'channel_id': '1'}]);
    });
    socket.on("message", (jsonData) {   //sample event
      //Convert the JSON data received into a Map
      print("THERE WAS A MESSAGE!!!!!");
      print(jsonData);
      var data = json.decode(jsonData);
      print(data);
      print("I'm right here!");
      this.setState(() => messages.add(data['message']));
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    });
    socket.connect();
  }

  Future<String> sendNewMessage(String channel_id, String message) async {
    var key = await storage.read(key: "jwt");
    var res = await http.post(
      'https://amigo-269801.appspot.com/api/channels/messages',
      headers: {
        "x-access-token": key
      },
      body: {
        "channel_id": channel_id,
        "message": message,
      }
    );
    print(res.statusCode);
    if(res.statusCode == 200) return res.body;
    return null;
  }

  Widget buildSingleMessage(int index) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          messages[index],
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ),
    );
  }

  Widget buildMessageList() {
    return Container(
      height: height * 0.8,
      width: width,
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          return buildSingleMessage(index);
        },
      ),
    );
  }

  Widget buildChatInput() {
    return Container(
      width: width * 0.7,
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.only(left: 40.0),
      child: TextField(
        decoration: InputDecoration.collapsed(
          hintText: 'Send a message...',
        ),
        controller: textController,
      ),
    );
  }

  Widget buildSendButton() {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      onPressed: () {
        //Check if the textfield has text or not
        if (textController.text.isNotEmpty) {
          this.sendNewMessage("1", textController.text);
          //Add the message to the list
          this.setState(() => messages.add(textController.text));
          textController.text = '';
          //Scrolldown the list to show the latest message
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 600),
            curve: Curves.ease,
          );
        }
      },
      child: Icon(
        Icons.send,
        size: 30,
      ),
    );
  }

  Widget buildInputArea() {
    return Container(
      height: height * 0.1,
      width: width,
      child: Row(
        children: <Widget>[
          buildChatInput(),
          buildSendButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(this.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: height * 0.1),
            buildMessageList(),
            buildInputArea(),
          ],
        ),
      ),
    );
  }
}







// const String _name = "Your Name";

// class ChatScreen extends StatefulWidget {
//   final String name;
//   final String id;

//   ChatScreen({Key key, @required this.name, @required this.id}) : super(key: key);
//   @override
//   State createState() => new ChatScreenState(name: name, id: id);
// }

// class ChatMessage extends StatelessWidget {
//   ChatMessage({this.text, this.animationController});
//   final String text;
//   final AnimationController animationController;
  
//   @override
//   Widget build(BuildContext context) {
//     return new SizeTransition(
//     sizeFactor: new CurvedAnimation(
//       parent: animationController, curve: Curves.easeOut),
//     axisAlignment: 0.0,
//     child: new Container(
//       margin: const EdgeInsets.symmetric(vertical: 10.0),
//       child: new Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             new Container(
//               margin: const EdgeInsets.only(right: 16.0),
//               child: new CircleAvatar(child: new Text(_name[0])),
//             ),
//             new Expanded(
//               child: new Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   new Text(_name, style: Theme.of(context).textTheme.subhead),
//                   new Container(
//                     margin: const EdgeInsets.only(top: 5.0),
//                     child: new Text(text),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       )
//     );
//   }
// }

// class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
//   final List<ChatMessage> _messages = <ChatMessage>[];
//   final TextEditingController _textController = new TextEditingController();
//   SocketIO socketIO;
//   List<String> messages;
//   double height, width;
//   TextEditingController textController;
//   ScrollController scrollController;
//   bool _isComposing = false;

//   final String name;
//   final String id;

//   ChatScreenState({Key key, @required this.name, @required this.id});

//   void initState() {
//     //Initializing the message list
//     messages = List<String>();
//     //Initializing the TextEditingController and ScrollController
//     textController = TextEditingController();
//     scrollController = ScrollController();
//     //Creating the socket
//     socketIO = SocketIOManager().createSocketIO(
//       '<ENTER THE URL OF YOUR DEPLOYED APP>',
//       '/',
//     );
//     //Call init before doing anything with socket
//     socketIO.init();
//     //Subscribe to an event to listen to
//     socketIO.subscribe('receive_message', (jsonData) {
//       //Convert the JSON data received into a Map
//       Map<String, dynamic> data = json.decode(jsonData);
//       this.setState(() => messages.add(data['message']));
//       scrollController.animateTo(
//         scrollController.position.maxScrollExtent,
//         duration: Duration(milliseconds: 600),
//         curve: Curves.ease,
//       );
//     });
//     //Connect to the socket
//     socketIO.connect();
//   }

//   Widget _buildTextComposer() {
//     return new IconTheme(
//       data: new IconThemeData(color: Theme.of(context).accentColor),
//       child: new Container(
//         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: new Row(
//           children: <Widget>[
//             new Flexible(
//               child: new TextField(
//                 controller: _textController,
//                 onChanged: (String text) {
//                   setState(() {
//                     _isComposing = text.length > 0;
//                   });
//                 },
//                 onSubmitted: _handleSubmitted,
//                 decoration:
//                     new InputDecoration.collapsed(hintText: "Send a message"),
//               ),
//             ),
//             new Container(
//               margin: new EdgeInsets.symmetric(horizontal: 4.0),
//               child: new IconButton(
//                 icon: new Icon(Icons.send),
//                 onPressed: _isComposing
//                     ? () => _handleSubmitted(_textController.text)
//                     : null,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _handleSubmitted(String text) {
//     _textController.clear();
//     setState(() {
//       _isComposing = false;
//     });
//     ChatMessage message = new ChatMessage(
//       text: text,
//       animationController: new AnimationController(
//         duration: new Duration(milliseconds: 700),
//         vsync: this,
//       ),
//     );
//     setState(() {
//       _messages.insert(0, message);
//     });
//     message.animationController.forward();
//   }

//   @override
//   void dispose() {
//     for (ChatMessage message in _messages)
//       message.animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         title: Text(this.name),
//         centerTitle: true,
//       ),
//       body: new Column(
//         children: <Widget>[
//           new Flexible(
//             child: new ListView.builder(
//               padding: new EdgeInsets.all(8.0),
//               reverse: true,
//               itemBuilder: (_, int index) => _messages[index],
//               itemCount: _messages.length,
//             ),
//           ),
//           new Divider(height: 1.0),
//           new Container(
//             decoration: new BoxDecoration(
//               color: Theme.of(context).cardColor),
//             child: _buildTextComposer(),
//           ),
//         ],
//       ),
//     );
//   }
// }