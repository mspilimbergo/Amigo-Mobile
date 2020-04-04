import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import './register_screen.dart';
import '../main/main_screen.dart';
import 'dart:convert' show json, base64, ascii;

final storage = FlutterSecureStorage();
final SERVER_URL = "http://10.0.2.2:3000";

class LoginPage extends StatelessWidget {
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome back,',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 12),
              child: Text(
                'Please sign in below'
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 12),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 12),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: new RaisedButton(
                  onPressed: () async {
                    var email = _emailController.text;
                    var password = _passwordController.text;
                    var res = await attemptLogIn(email, password);
                    if (res == null) {
                      displayDialog(context, "Error", "Please try again or register if you don't already have an account");
                      return;
                    }
                    var jsonRes = json.decode(res);
                    if(jsonRes["success"]) {
                      var jwt = jsonRes["x-access-token"];
                      storage.write(key: "jwt", value: jwt);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage()
                        )
                      );
                    } else {
                      displayDialog(context, jsonRes["message"], "Please try again or register if you don't already have an account");
                    }
                  },
                  child: Text("Log In")
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
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: Text("Don't have an account yet? Sign up!")
              )
            )
          ],
        ),
      )
    );
  }
}