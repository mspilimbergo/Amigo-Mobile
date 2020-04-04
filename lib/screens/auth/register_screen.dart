import 'package:amigo_mobile/screens/chat/user_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:amigo_mobile/screens/auth/login_screen.dart';

final storage = FlutterSecureStorage();
final SERVER_URL = "https://amigo-269801.appspot.com";

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  String schoolId;

  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) =>
      AlertDialog(
        title: Text(title),
        content: Text(text)
      ),
  );

  Future<String> attemptSignUp(String email, String password, String confirm, String firstName, String lastName, String displayName, String schoolId) async {
    var res = await http.post(
      '$SERVER_URL/api/signup',
      body: {
        "email": email,
        "password": password,
        "confirmation_password": confirm,
        "first_name": firstName,
        "last_name": lastName,
        "display_name": displayName,
        "school_id": schoolId
      }
    );
    if(res.statusCode == 200) return res.body;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, top: MediaQuery.of(context).size.height / 12, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sign Up',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Sign up to join'
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password'
              ),
            ),
            TextField(
              controller: _confirmController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password'
              ),
            ),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name'
              ),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name'
              ),
            ),
            DropdownButton(
              items: <String>['A', 'B', 'C', 'D'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String selectedSchool) {
                schoolId = selectedSchool;
              }
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 20),
              child: TextField(
                controller: _displayNameController,
                decoration: InputDecoration(
                  labelText: 'Display Name'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: new RaisedButton(
                  onPressed: () async {
                    var email = _emailController.text;
                    var password = _passwordController.text;
                    var confirm = _confirmController.text;
                    var firstName = _firstNameController.text;
                    var lastName = _lastNameController.text;
                    var displayName = _displayNameController.text;
                    var res = await attemptSignUp(email, password, confirm, firstName, lastName, displayName, schoolId);
                    if (res == null) {
                      displayDialog(context, "Error", "An error occured, please try registering again.");
                      return;
                    }
                    var jsonRes = json.decode(res);
                    if(jsonRes["success"]) {
                      displayDialog(context, "Success!", jsonRes["message"] + "Please verify the account with the email provided and then login with your credentials.");
                    } else {
                      displayDialog(context, "Error", "Error with values provided, please fix errors and try again");
                    }
                  },
                  child: Text("Sign Up")
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
                child: Text("Already have an account? Log in!")
              )
            )
          ],
        ),
      )
    );
  }
}