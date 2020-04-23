import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myapp/theme/style.dart';
import 'package:myapp/components/FadeAnimation.dart';

class ForgotForm extends StatefulWidget {
  @override
  ForgotFormState createState() {
    return ForgotFormState();
  }
}

class ForgotFormState extends State<ForgotForm> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  var creds;
  dynamic token;

  TextEditingController emailControler = new TextEditingController();

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
                      )),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 90,
                          ),
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
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: new TextFormField(
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
                                        return 'Please enter an email';
                                      }
                                      return null;
                                    },
                                    onSaved: (val) => _email = val,
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 80,
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
                                    _createEmail(_email);
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

_createEmail(email) async {
  var emailaddress =
      'mailto:$email?subject=Sample Subject&body=This is your password: 123456';
  if (await canLaunch(emailaddress)) {
    await launch(emailaddress);
  } else {
    throw 'Could not Email';
  }
}
