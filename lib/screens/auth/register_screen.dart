import 'package:amigo_mobile/screens/chat/user_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:amigo_mobile/screens/auth/login_screen.dart';
import 'package:amigo_mobile/util/colors.dart';

final storage = FlutterSecureStorage();
final SERVER_URL = "https://amigo-269801.appspot.com";

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  Map school;

  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) =>
      AlertDialog(
        title: Text(title),
        content: Text(text)
      ),
  );

  Future<String> attemptSignUp() async {
    var res = await http.post(
      '$SERVER_URL/api/signup',
      body: {
        "email": _emailController.text,
        "password": _passwordController.text,
        "confirmation_password": _confirmController.text,
        "first_name": _firstNameController.text,
        "last_name": _lastNameController.text,
        "display_name": _displayNameController.text,
        "school_id": school["school_id"];
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
                  'Welcome back,',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 12),
                  child: Text(
                    'Please sign in below',
                    style: new TextStyle(color: Colors.grey)
                  ),
                ),
                TextField(
                  controller: _displayNameController,
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1.5,
                    color: Colors.black                  
                  ),
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(width: 4.0, color: Colors.grey[350]),
                    ),  
                    focusedBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(width: 4.0, color: amigoRed),
                    ),
                  ),
                ),
                TextField(
                  controller: _firstNameController,
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1.5,
                    color: Colors.black                  
                  ),
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(width: 4.0, color: Colors.grey[350]),
                    ),  
                    focusedBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(width: 4.0, color: amigoRed),
                    ),
                  ),
                ),
                TextField(
                  controller: _lastNameController,
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1.5,
                    color: Colors.black                  
                  ),
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(width: 4.0, color: Colors.grey[350]),
                    ),  
                    focusedBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(width: 4.0, color: amigoRed),
                    ),
                  ),
                ),
                TextField(
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
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1.5,
                    color: Colors.black                  
                  ),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(width: 4.0, color: Colors.grey[350]),
                    ),  
                    focusedBorder: new UnderlineInputBorder(
                      borderSide: BorderSide(width: 4.0, color: amigoRed),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 12),
                  child: TextField(
                    controller: _confirmController,
                    obscureText: true,
                    style: TextStyle(
                      fontSize: 16.0,
                      height: 1.5,
                      color: Colors.black                  
                    ),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
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
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 12),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 14.0,
                    child: new FlatButton(
                      color: amigoRed,
                      textColor: Colors.white,
                      onPressed: () async {
                        var res = await attemptSignUp();
                        if (res == null) {
                          displayDialog(context, "Error", "An error occured please try again");
                          return;
                        }
                        var jsonRes = json.decode(res);
                        if(jsonRes["success"]) {
                          displayDialog(context, "Success!", jsonRes["message"] + "Please verify the account with the email provided and then login with your credentials.");
                        } else {
                          displayDialog(context, "Error", "Error with values provided, please fix errors and try again");
                        }
                      },
                      child: Text("Sign up", style: TextStyle(fontSize: 16.0))
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
                          new TextSpan(text: 'Don\'t have an account yet? '),
                          new TextSpan(text: 'Sign up now!', style: new TextStyle(color: amigoRed, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  )
                )
              ],
            ),
          )
        )
      )
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       padding: EdgeInsets.only(left: 30.0, right: 30.0, top: MediaQuery.of(context).size.height / 12, bottom: 20.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Text(
  //             'Sign Up',
  //             textAlign: TextAlign.left,
  //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(bottom: 30.0),
  //             child: Text(
  //               'Sign up to join'
  //             ),
  //           ),
  //           TextField(
  //             controller: _emailController,
  //             decoration: InputDecoration(
  //               labelText: 'Email'
  //             ),
  //           ),
  //           TextField(
  //             controller: _passwordController,
  //             obscureText: true,
  //             decoration: InputDecoration(
  //               labelText: 'Password'
  //             ),
  //           ),
  //           TextField(
  //             controller: _confirmController,
  //             obscureText: true,
  //             decoration: InputDecoration(
  //               labelText: 'Confirm Password'
  //             ),
  //           ),
  //           TextField(
  //             controller: _firstNameController,
  //             decoration: InputDecoration(
  //               labelText: 'First Name'
  //             ),
  //           ),
  //           TextField(
  //             controller: _lastNameController,
  //             decoration: InputDecoration(
  //               labelText: 'Last Name'
  //             ),
  //           ),
  //           DropdownButton(
  //             items: <String>['A', 'B', 'C', 'D'].map((String value) {
  //               return new DropdownMenuItem<String>(
  //                 value: value,
  //                 child: new Text(value),
  //               );
  //             }).toList(),
  //             onChanged: (String selectedSchool) {
  //               schoolId = selectedSchool;
  //             }
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 20),
  //             child: TextField(
  //               controller: _displayNameController,
  //               decoration: InputDecoration(
  //                 labelText: 'Display Name'
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 20),
  //             child: SizedBox(
  //               width: MediaQuery.of(context).size.width,
  //               child: new RaisedButton(
  //                 onPressed: () async {
  //                   var email = _emailController.text;
  //                   var password = _passwordController.text;
  //                   var confirm = _confirmController.text;
  //                   var firstName = _firstNameController.text;
  //                   var lastName = _lastNameController.text;
  //                   var displayName = _displayNameController.text;
  //                   var res = await attemptSignUp(email, password, confirm, firstName, lastName, displayName, schoolId);
  //                   if (res == null) {
  //                     displayDialog(context, "Error", "An error occured, please try registering again.");
  //                     return;
  //                   }
  //                   var jsonRes = json.decode(res);
  //                   if(jsonRes["success"]) {
  //                     displayDialog(context, "Success!", jsonRes["message"] + "Please verify the account with the email provided and then login with your credentials.");
  //                   } else {
  //                     displayDialog(context, "Error", "Error with values provided, please fix errors and try again");
  //                   }
  //                 },
  //                 child: Text("Sign Up")
  //               )
  //             ),
  //           ),
  //           SizedBox(
  //             width: MediaQuery.of(context).size.width,
  //             child: new FlatButton(
  //               onPressed: () async {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => LoginPage(),
  //                   ),
  //                 );
  //               },
  //               child: Text("Already have an account? Log in!")
  //             )
  //           )
  //         ],
  //       ),
  //     )
  //   );
  // }
}