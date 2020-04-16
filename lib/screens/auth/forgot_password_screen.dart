import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:amigo_mobile/screens/auth/login_screen.dart';
import 'package:amigo_mobile/util/colors.dart';
import 'dart:convert' show json;

final storage = FlutterSecureStorage();
final SERVER_URL = "https://amigo-269801.appspot.com";

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) =>
      AlertDialog(
        title: Text(title),
        content: Text(text)
      ),
    );

  Future<String> attemptLogIn(String email, String password) async {
    var res = await http.post(
      "$SERVER_URL/api/login",
      body: {
        "email": email,
        "password": password
      }
    );
    if(res.statusCode == 200) return res.body;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: 
      Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Forgot?',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45.0),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 12),
                  child: Text(
                    'Enter your email to send a reset password link.',
                    style: new TextStyle(color: Colors.grey, fontSize: 16.0)
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 10),
                  child: TextField(
                    controller: _emailController,
                    style: TextStyle(
                      fontSize: 16.0,
                      height: 1.5,
                      color: Colors.black                  
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(width: 4.0, color: Colors.grey[350]),
                      ),  
                      focusedBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(width: 4.0, color: amigoRed),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 14),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 14.0,
                    child: new FlatButton(
                      color: amigoRed,
                      textColor: Colors.white,
                      onPressed: () async {
                        var email = _emailController.text;
                        var password = _passwordController.text;
                        var res = await attemptLogIn(email, password);
                        if (res == null) {
                          displayDialog(context, "Error", "There was an error sending the reset email. Please check your email and try again.");
                          return;
                        }
                        var jsonRes = json.decode(res);
                        if(jsonRes["success"]) {
                          displayDialog(context, "Success!", "Link sent succesfully, go to your email for further instructions on resetting your password.");
                        } else {
                          displayDialog(context, jsonRes["message"], "Your username or password was incorrect. Please try again or go to the register screen and create an account.");
                        }
                      },
                      child: Text("Send Reset Link", style: TextStyle(fontSize: 16.0))
                    )
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: new FlatButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: new RichText(
                      text: new TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                        children: <TextSpan>[
                          new TextSpan(text: 'Remembered your password? '),
                          new TextSpan(text: 'Log in now!', style: new TextStyle(color: amigoRed, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  )
                ),
              ],
            ),
          )
        )
      )
    );
  }
}