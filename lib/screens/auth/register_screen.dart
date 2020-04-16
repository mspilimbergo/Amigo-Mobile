import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:amigo_mobile/screens/auth/login_screen.dart';
import 'package:amigo_mobile/util/colors.dart';
import 'package:amigo_mobile/screens/auth/school_search_delegate.dart';

final storage = FlutterSecureStorage();
final SERVER_URL = "http://10.0.2.2:3000";

class RegisterPage extends StatefulWidget {
  final Map school;
  RegisterPage({Key key, @required this.school}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState(school: school);
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  Map school;

  _RegisterPageState({Key key, @required this.school});

  @override
  void initState() {
    super.initState();
  }

  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) =>
      AlertDialog(
        title: Text(title),
        content: Text(text)
      ),
  );

  Future<String> attemptSignUp() async {
    print("I got this far");
    if (school == null) {
      displayDialog(context, "Error", "You must provide a school");
    }
    var res = await http.post(
      '$SERVER_URL/api/signup',
      body: {
        "email": _emailController.text,
        "password": _passwordController.text,
        "confirmation_password": _confirmController.text,
        "first_name": _firstNameController.text,
        "last_name": _lastNameController.text,
        "display_name": _displayNameController.text,
        "school_id": school['school_id']
      }
    );
    print(res.body);
    return res.body;
  }

    @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: 
      Scaffold(
        backgroundColor: Colors.white,
        body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          behavior: HitTestBehavior.translucent,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 30.0, right: 30.0, top: MediaQuery.of(context).size.height / 10),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign Up',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Sign up to join!',
                      style: new TextStyle(color: Colors.grey, fontSize: 18.0)
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
                      labelText: 'Display Name',
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
                  GestureDetector(
                    onTap: () async {
                      var res = await showSearch(
                        context: context,
                        delegate: SchoolSearchDelegate()
                      );
                      print(res);
                      setState(() {
                        school = json.decode(res);
                      });
                      _schoolController.text = school['name'];
                    },
                    behavior: HitTestBehavior.translucent,
                    child: TextField(
                      enabled: false,
                      controller: _schoolController,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'School',
                        labelStyle: TextStyle(color: Colors.black),
                        disabledBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(width: 4.0, color: Colors.grey[350]),
                        ),
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(width: 4.0, color: Colors.grey[350]),
                        ),  
                        focusedBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(width: 4.0, color: amigoRed),
                        ),
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
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 20),
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
                          print(jsonRes);
                          if(jsonRes["success"]) {
                            displayDialog(context, "Success!", jsonRes["message"] + "Please verify the account with the email provided and then login with your credentials.");
                          } else {
                            var errors = StringBuffer();
                            print(jsonRes['errors']);
                            jsonRes['errors'].forEach((item) => {
                              errors.writeln(item['msg'])
                            });
                            displayDialog(context, "Error", errors.toString());
                          }
                        },
                        child: Text("Sign up", style: TextStyle(fontSize: 16.0))
                      )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 20),
                    child: SizedBox(
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
                              new TextSpan(text: 'Already have an account yet? '),
                              new TextSpan(text: 'Log in!', style: new TextStyle(color: amigoRed, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      )
                    )
                  )
                ],
              ),
            )
          )
        )
      )
    );
  }
}