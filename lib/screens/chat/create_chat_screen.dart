import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:getflutter/getflutter.dart';
import './chat_screen.dart';

final storage = FlutterSecureStorage();

class CreateChatPage extends StatefulWidget {
  final TextEditingController _recipientController = TextEditingController();
  final String display;
  final String sender;
  String name = "";
  String id = "";

  CreateChatPage({Key key, @required this.display, @required this.sender}) : super(key: key);
  @override
  _CreateChatState createState() => _CreateChatState(display: display, sender: sender);
}

class _CreateChatState extends State<CreateChatPage> {
  String name = "";
  String id = "";
  final String display;
  final String sender;

  _CreateChatState({Key key, @required this.display, @required this.sender});


  Widget build(BuildContext context) {
  List list = [
    "Flutter",
    "React",
    "Ionic",
    "Xamarin",
  ];
  
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(
          color: Colors.red[200], //change your color here
        ),
        title: Text("Create", style: TextStyle(
          color: Colors.black,
        )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, top: MediaQuery.of(context).size.height / 6, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Create Direct Message',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
                  ),
                  Text(
                    'Send an initial direct message to someone below!',
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 12),
              child: GFSearchBar(
                searchList: list,
                searchQueryBuilder: (query, list) {
                  return list
                      .where((item) =>
                          item.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                },
                overlaySearchListItemBuilder: (item) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                },
                onItemSelected: (item) {
                  setState(() {
                    print('$item');
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: new RaisedButton(
                  onPressed: () async {
                    // var email = _emailController.text;
                    // var password = _passwordController.text;
                    // var confirm = _confirmController.text;
                    // var firstName = _firstNameController.text;
                    // var lastName = _lastNameController.text;
                    // var displayName = _displayNameController.text;
                    // var res = await attemptSignUp(email, password, confirm, firstName, lastName, displayName);
                    // if (res == null) {
                    //   displayDialog(context, "Error", "An error occured, please try registering again.");
                    //   return;
                    // }
                    // var jsonRes = json.decode(res);
                    // if(jsonRes["success"]) {
                    //   displayDialog(context, "Success!", jsonRes["message"] + "Please verify the account with the email provided and then login with your credentials.");
                    // } else {
                    //   displayDialog(context, "Error", "Error with values provided, please fix errors and try again");
                    // }
                    MaterialPageRoute(
                      builder: (context) => ChatPage(name: name, id: id, display: display, sender: sender, direct: true)
                    );
                  },
                  child: Text("Continue")
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

}