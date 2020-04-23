import 'package:flutter/material.dart';
import 'package:myapp/screens/login.dart';

//import 'package:user_management/main.dart' as manage;


void main() => runApp(MyApp());
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    

    return MaterialApp(
          
      home: Scaffold(
        
        body: LoginScreenForm())); 
      
    
  }
}
