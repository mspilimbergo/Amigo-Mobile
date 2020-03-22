import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../main/main_screen.dart';

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

  Future<int> attemptSignUp(String email, String password) async {
    var res = await http.post(
      '$SERVER_URL/api/signup',
      body: {
        "email": email,
        "password": password
      }
    );
    return res.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Log In"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
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
            FlatButton(
              onPressed: () async {
                var email = _emailController.text;
                var password = _passwordController.text;
                var res = await attemptLogIn(email, password);
                print(res);
                // if(jwt != null) {
                //   storage.write(key: "jwt", value: jwt);
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => MainPage.fromBase64(jwt)
                //     )
                //   );
                // } else {
                //   displayDialog(context, "An Error Occurred", "No account was found matching that email and password");
                // }
              },
              child: Text("Log In")
            ),
            FlatButton(
              onPressed: () async {
                var email = _emailController.text;
                var password = _passwordController.text;

                if(email.length < 4) 
                  displayDialog(context, "Invalid email", "The email should be at least 4 characters long");
                else if(password.length < 4) 
                  displayDialog(context, "Invalid Password", "The password should be at least 4 characters long");
                else{
                  var res = await attemptSignUp(email, password);
                  if(res == 201)
                    displayDialog(context, "Success", "The user was created. Log in now.");
                  else if(res == 409)
                    displayDialog(context, "That email is already registered", "Please try to sign up using another email or log in if you already have an account.");  
                  else {
                    displayDialog(context, "Error", "An unknown error occurred.");
                  }
                }
              },
              child: Text("Sign Up")
            )
          ],
        ),
      )
    );
  }
}