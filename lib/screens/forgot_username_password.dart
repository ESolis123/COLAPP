import 'package:flutter/material.dart';
import 'package:myapp/components/forgot_username_password.dart';

class ForgotScreenForm extends StatefulWidget {
  @override
  ForgotScreenFormState createState() {
    return ForgotScreenFormState();
  }
}

class ForgotScreenFormState extends State<ForgotScreenForm> {
 
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: ForgotForm()));
  }
}
