import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

final storage = FlutterSecureStorage();

class ChatPage extends StatefulWidget {
  final String name;
  final String id;
  final String display;

  ChatPage({Key key, @required this.name, @required this.id, @required this.display}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState(name: name, id: id, display: display);
}

class _ChatPageState extends State<ChatPage> {
  final String name;
  final String id;
  final String display;
  List<Map> messages = new List<Map>();
  double height, width;
  SocketIOManager manager;
  TextEditingController textController;
  ScrollController scrollController;
  Map<String, bool> _isProbablyConnected = {};
  Map<String, SocketIO> sockets = {};


  _ChatPageState({Key key, @required this.name, @required this.id, @required this.display});

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
        "https://amigo-269801.appspot.com",
        enableLogging: true,
        transports: [Transports.WEB_SOCKET, Transports.POLLING]
    ));
    socket.onConnect((data){
      print("Connected...");
      print(data);
      socket.emit('join', [{'token': key, 'channel_id': id.toString()}]);
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
      this.setState(() => messages.add(map));
      var scrollPosition = scrollController.position;
      scrollController.jumpTo(
        scrollPosition.maxScrollExtent
      );
    });
    socket.connect();
    sockets[identifier] = socket;
  }

  initMessages() async {
    String jsonSnap = await getMessages();
    Map map = json.decode(jsonSnap);
    for(var i = 0; i < map["messages"].length; ++i) {
      this.setState(() => messages.add(map["messages"][i]));
    }
    // var scrollPosition = scrollController.position;
    // scrollController.jumpTo(
    //   scrollPosition.maxScrollExtent
    // );
  }

  Future<String> getMessages() async {
    var key = await storage.read(key: "jwt");
    var res = await http.get(
      "https://amigo-269801.appspot.com/api/channels/messages?channel_id=$id",
      headers: {
        "x-access-token": key
      }
    );
    print(res.statusCode);
    if(res.statusCode == 200) return res.body;
    return null;
  }

  Future<String> sendNewMessage(String message) async {
    var key = await storage.read(key: "jwt");
    print(id);
    var res = await http.post(
      'https://amigo-269801.appspot.com/api/channels/messages',
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
          alignment: display == messages[index]["display_name"] ? Alignment.centerLeft : Alignment.centerRight,
          margin: display == messages[index]["display_name"] ? const EdgeInsets.only(bottom: 2.0, left: 12.0) : const EdgeInsets.only(bottom: 2.0, right: 12.0),
          child: Text(messages[index]["display_name"])
        ),
        Container(
          alignment: display == messages[index]["display_name"] ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            margin: display == messages[index]["display_name"] ? const EdgeInsets.only(bottom: 10.0, left: 10.0) : const EdgeInsets.only(bottom: 10.0, right: 10.0),
            decoration: BoxDecoration(
              color: Colors.red[200],
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
          onPressed: () {
            //Check if the textfield has text or not
            if (textController.text.isNotEmpty) {
            this.sendNewMessage(textController.text);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(this.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildMessageList(),
            buildInputArea(),
          ],
        ),
      ),
    );
  }
}
