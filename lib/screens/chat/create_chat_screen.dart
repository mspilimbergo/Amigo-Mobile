import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './chat_screen.dart';

final storage = FlutterSecureStorage();

class CreateChatPage extends StatelessWidget {
  final TextEditingController _recipientController = TextEditingController();
  final String display;
  final String sender;
  String name = "";
  String id = "";

  CreateChatPage({Key key, @required this.display, @required this.sender}) : super(key: key);

  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Create Direct Message',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Send an initial direct message to someone below!'
              ),
            ),
            TextField(
              controller: _recipientController,
              decoration: InputDecoration(
                labelText: 'Recipient Display Name'
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
                  child: Text("Sign Up")
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

}