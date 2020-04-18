import 'dart:convert';
import 'dart:math';
import 'package:amigo_mobile/screens/main/main_screen.dart';
import 'package:amigo_mobile/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

final storage = FlutterSecureStorage();
final SERVER_URL = "https://amigo-269801.appspot.com";

class ChatPage extends StatefulWidget {
  final String name;
  final String id;
  final String display;
  final String sender;
  final String photo;
  final bool direct;

  ChatPage({Key key, @required this.name, @required this.id, @required this.display, @required this.sender, @required this.direct, @required this.photo}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState(name: name, id: id, display: display, sender: sender, direct: direct, photo: photo);
}

class _ChatPageState extends State<ChatPage> {
  final String name;
  final String id;
  final String display;
  final String sender;
  final String photo;
  final bool direct;

  List<Map> messages = new List<Map>();
  double height, width;
  SocketIOManager manager;
  TextEditingController textController;
  ScrollController scrollController;
  Map<String, bool> _isProbablyConnected = {};
  Map<String, SocketIO> sockets = {};


  _ChatPageState({Key key, @required this.name, @required this.id, @required this.display, @required this.sender, @required this.direct, @required this.photo});

  @override
  void initState() {
    manager = SocketIOManager();
    textController = TextEditingController();
    scrollController = ScrollController();
    initMessages();
    initSocket("default");
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
    disconnect("default");
  }

  bool isProbablyConnected(String identifier){
    return _isProbablyConnected[identifier]??false;
  }

  disconnect(String identifier) async {
    await manager.clearInstance(sockets[identifier]);
    setState(() => _isProbablyConnected[identifier] = false);
  }

  initSocket(String identifier) async {
    setState(() => _isProbablyConnected[identifier] = true);
    var key = await storage.read(key: "jwt");
    SocketIO socket = await manager.createInstance(SocketOptions(
        "$SERVER_URL",
        enableLogging: true,
        transports: [Transports.WEB_SOCKET, Transports.POLLING]
    ));
    socket.onConnect((data){
      print("Connected...");
      print(data);
      !direct
      ? socket.emit('join', [{'token': key, 'channel_id': id.toString()}])
      : socket.emit('join', [{'token': key, 'receiver_user_id': id.toString()}]);
    });
    socket.onConnectError((data) {
      print("Connect Error");
      print(data);
    });
    socket.onConnectTimeout((data) {
      print("Timeout");
      print(data);
    });
    socket.onError((data) {
      print("Error");
      print(data);
    });
    socket.onDisconnect((data) {
      print("Disconnect");
      print(data);
    });
    socket.on("message", (jsonData) {   //sample event
      print("THERE WAS A MESSAGE!!!!!");
      print(jsonData);
      Map map = jsonData;
      print(map);
      this.setState(() => messages.insert(0, map));
      scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    });
    socket.connect();
    sockets[identifier] = socket;
  }

  initMessages() async {
    String jsonSnap = direct ? await getDirectMessages() : await getChannelMessages();
    Map map = json.decode(jsonSnap);
    for (var i = map["messages"].length - 1; i >= 0; --i) {
      this.setState(() => messages.add(map["messages"][i]));
    }
  }

  Future<String> getChannelMessages() async {
    var key = await storage.read(key: "jwt");
    var res = await http.get(
      "$SERVER_URL/api/channels/messages?channel_id=$id",
      headers: {
        "x-access-token": key
      }
    );
    print(res.statusCode);
    if(res.statusCode == 200) return res.body;
    return null;
  }

  Future<String> getDirectMessages() async {
    var key = await storage.read(key: "jwt");
    var res = await http.get(
      "$SERVER_URL/api/directmessages?receiver_user_id=$id",
      headers: {
        "x-access-token": key
      }
    );
    print(res.body);
    print(res.statusCode);
    if(res.statusCode == 200) return res.body;
    return null;
  }

  Future<String> sendDirectMessage(String message) async {
    var key = await storage.read(key: "jwt");
    print("Sending a direct message");
    var res = await http.post(
      "$SERVER_URL/api/directmessages",
      body: {
        "message": message,
        "receiver_user_id": id,
      },
      headers: {
        "x-access-token": key
      }
    );
    print(res.body);
    print(res.statusCode);
    if(res.statusCode == 200) return res.body;
    return null;
  }

  Future<String> sendChannelMessage(String message) async {
    var key = await storage.read(key: "jwt");
    print(id);
    var res = await http.post(
      '$SERVER_URL/api/channels/messages',
      headers: {
        "x-access-token": key
      },
      body: {
        "channel_id": id,
        "message": message,
      }
    );
    print(res.statusCode);
    if(res.statusCode == 200) return res.body;
    return null;
  }

  Widget buildSingleMessage(int index) {
    return Column(
      children: <Widget> [
        Container(
          alignment: !direct
          ? (display == messages[index]["display_name"] ? Alignment.centerRight : Alignment.centerLeft)
          : (display == messages[index]["sender_display_name"] ? Alignment.centerRight : Alignment.centerLeft),
          margin: !direct
          ? (display == messages[index]["display_name"] ? const EdgeInsets.only(bottom: 2.0, right: 12.0) : const EdgeInsets.only(bottom: 2.0, left: 12.0))
          : (display == messages[index]["sender_display_name"] ? const EdgeInsets.only(bottom: 2.0, right: 12.0) : const EdgeInsets.only(bottom: 2.0, left: 12.0)),
          child: !direct
          ? Text(messages[index]["display_name"])
          : Text(messages[index]["sender_display_name"])
        ),
        Container(
          alignment: !direct
          ? (display == messages[index]["display_name"] ? Alignment.centerRight : Alignment.centerLeft)
          : (display == messages[index]["sender_display_name"] ? Alignment.centerRight : Alignment.centerLeft),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300.0),
            padding: const EdgeInsets.all(10.0),
            margin: !direct
            ? (display == messages[index]["display_name"] ? const EdgeInsets.only(bottom: 10.0, right: 10.0) : const EdgeInsets.only(bottom: 10.0, left: 10.0))
            : (display == messages[index]["sender_display_name"] ? const EdgeInsets.only(bottom: 10.0, right: 10.0) : const EdgeInsets.only(bottom: 10.0, left: 10.0)),
            decoration: BoxDecoration(
              color: !direct
              ? (display == messages[index]["display_name"] ? amigoRed[200] : Colors.grey[200])
              : (display == messages[index]["sender_display_name"] ? amigoRed[200] : Colors.grey[200]),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              messages[index]["message"],
              style: TextStyle(color: Colors.black, fontSize: 15.0),
            ),
          ),
        )
      ]
    );
  }

  Widget buildMessageList() {
    return Container(
      height: height * 0.8,
      width: width,
      padding: const EdgeInsets.all(2.0),
      child: ListView.builder(
        shrinkWrap: true,
        reverse: true,
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
    return Container(
      width: width * 0.1,
      height: height * 0.1,
      child: new RawMaterialButton(
        shape: new CircleBorder(),
        elevation: 0.0,
        child: Icon(
          Icons.send,
          color: Colors.red[100]        
          ),
        onPressed: () async {
          //Check if the textfield has text or not
          if (textController.text.isNotEmpty) {
            !direct ? await sendChannelMessage(textController.text) : await sendDirectMessage(textController.text);
            //Add the message to the list
            textController.text = '';
          }
        }
      )
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
    return WillPopScope(
      onWillPop: () {
        disconnect("default");
        return Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => MainPage(initialIndex: 0)),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          iconTheme: IconThemeData(
            color: amigoRed,
          ),
          title: Text(this.name, style: TextStyle(
            color: Colors.black,
          )),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: this.photo != null ? NetworkImage(this.photo + "?v=${Random().nextInt(10000000).toString()}") : AssetImage('assets/placeholder.png'),
                    radius: 25.0,
                  ),
                )
              )
            ),
          ]
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildMessageList(),
              buildInputArea(),
            ],
          ),
        ),
      )
    );
  }
}
