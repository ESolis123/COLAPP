import 'package:flutter/material.dart';
import 'package:myapp/screens/forgot_username_password.dart';
import 'package:myapp/services/api.dart';
import 'package:myapp/screens/home.dart';
import 'dart:convert';
import 'package:myapp/globals/global.dart' as globals;
import 'package:myapp/components/FadeAnimation.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;
  var creds;
  dynamic token;
  bool _alertView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.blue),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Text(
                            "COLAPP",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontFamily: 'Monserrat',
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                          1.3,
                          Text(
                            "Bienvenido",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Monserrat',
                                fontWeight: FontWeight.normal),
                          )),
                    ],
                  ),
                ),
                
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(30),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: "Nombre de usuario",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Por favor, entre un nombre de usuario';
                                            }
                                            return null;
                                          },
                                          onSaved: (val) => _username = val,
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: TextFormField(
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              hintText: "Contraseña",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter a password';
                                            }
                                            return null;
                                          },
                                          onSaved: (pssw) => _password = pssw,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                              1.5,
                              InkWell(
                                  child: new Text('¿Olvidó la contraseña?'),
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotScreenForm()))),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                                1.6,
                                RaisedButton(
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      var data = {
                                        'username': _username,
                                        'password': _password
                                      };
                                      var creds = await loginCredentials(
                                          context, globals.urltoken,
                                          body: data);
                                      if (creds.statusCode == 200) {
                                        globals.token= json.decode(
                                                        creds.body)["token"];
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => GoalList(
                                                    token: json.decode(
                                                        creds.body)["token"])));
                                        setState(() => _alertView = false);
                                        
                                      } else {
                                        print('prueba');
                                        setState(() => _alertView = true);
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    margin: EdgeInsets.symmetric(horizontal: 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.blue),
                                    child: Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                           
                            SizedBox(height: 20,),
                            FadeAnimation(
                              1.5,
                              InkWell(
                                  child: SizedBox(
                                height: 200,
                                width: 300,
                                child: new Text(
                                    'Al entrar, estará aceptando nuestras políticas de uso'),
                              )),
                            ),
                            Opacity(
                              opacity: _alertView ? 1.0 : 0.0,
                              child: Container(
                                margin: const EdgeInsets.all(10.0),
                                width: 300.0,
                                height: 48.0,
                                alignment: Alignment.center,
                                child: Text(
                                  'Login fallido',
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
            )),
      ),
    );
  }
}
