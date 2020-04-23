import 'package:flutter/material.dart';
import 'package:myapp/services/api.dart';
import 'package:myapp/main.dart';
import 'package:myapp/globals/user.dart';
import 'package:myapp/theme/style.dart';
import 'package:myapp/components/FadeAnimation.dart';

class CreateUserForm extends StatefulWidget {
  @override
  CreateUserFormState createState() {
    return CreateUserFormState();
  }
}

class CreateUserFormState extends State<CreateUserForm> {
  final _formKey = GlobalKey<FormState>();

  String _password;

  String _password2;
  var creds;
  dynamic token;
  bool _alertView = false;
  TextEditingController usernameControler = new TextEditingController();
  TextEditingController emailControler = new TextEditingController();
  TextEditingController passwordControler = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(color: darkPurple),
        child: Form(
          key: _formKey,
          child: Column(
            // settings
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            // content
            children: <Widget>[
                SizedBox(
                        height: 90,
                      ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                          //topRight: Radius.circular(100)
                          )
                          ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        children: <Widget>[
                          
                          FadeAnimation(
                              1.4,
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(225, 95, 27, .3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: new TextFormField(
                                        controller: usernameControler,
                                        decoration: const InputDecoration(
                                          border: InputBorder
                                              .none,
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(0.0),
                                          ),
                                          labelText: 'Username',
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter a username';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        controller: emailControler,
                                        decoration: const InputDecoration(
                                         
                                          border: InputBorder
                                              .none, 
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(0.0),
                                          ),
                                          labelText: 'Email',
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter a email';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        obscureText:
                                            true, 
                                        controller: passwordControler,
                                        decoration: const InputDecoration(
                                          
                                          border: InputBorder
                                              .none, 
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(0.0),
                                          ),
                                          labelText: 'Password',
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter a password';
                                          }

                                          return null;
                                        },
                                        onSaved: (pass) => _password = pass,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        obscureText:
                                            true, 
                                        decoration: const InputDecoration(
                                          
                                          border: InputBorder
                                              .none, 
                                          prefixIcon: Padding(
                                         
                                            padding: EdgeInsets.all(0.0),
                                          ),
                                          labelText: 'Password',
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter a password';
                                          } else if (_password != _password2) {
                                            return 'The passwords doesnt match';
                                          }
                                          return null;
                                        },
                                        onSaved: (pssw2) => _password2 = pssw2,
                                      ),
                                    ),
                                  
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 40,
                          ),
                                                   
                          SizedBox(
                            height: 10,
                          ),
                          FadeAnimation(
                              1.6,
                              RaisedButton(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      Account newPost = new Account(
                          username: usernameControler.text,
                          email: emailControler.text,
                          password: passwordControler.text);

                      final url = 'http://10.0.2.2:8000/user/create/';
                      var creds =
                          await createUser(context, url, newPost.toMap(), token);
                      if (creds.statusCode == 200 || creds.statusCode == 201 ) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                        setState(() => _alertView = false);
                      } else {
                        setState(() => _alertView = true);
                      }
                    }

                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: darkPurple),
                                  child: Center(
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )),
                          Opacity(
                            opacity: _alertView ? 1.0 : 0.0,
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              width: 300.0,
                              height: 48.0,
                              alignment: Alignment.center,
                              child: Text(
                                'There was an error in the creating process',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
