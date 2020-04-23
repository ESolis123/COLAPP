import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/services/api.dart';
import 'package:myapp/globals/global.dart' as globals;
import 'package:myapp/globals/user.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class  AgregarProveedores extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AgregarProveedoresState();
  }
  }

class AgregarProveedoresState extends State<StatefulWidget>{
    bool _validate1 = false, _validate2 = false, _validate3 = false, _validate4 = false;
   
  TextEditingController nameControler = TextEditingController();
  TextEditingController descriptionControler = TextEditingController();
  TextEditingController directionControler = TextEditingController();
  TextEditingController telephoneControler = TextEditingController();
  TextEditingController statusControler = TextEditingController();
  String checkbox='';
  bool checkBoxValue = false;


  @override
  Widget build(BuildContext context) {
   
  
    return Scaffold(
        appBar: AppBar(
          title: Text('Agregar proveedor'),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            
            Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameControler,
                  decoration: InputDecoration(
                    labelText: 'Nombre del proveedor',
                    errorText: _validate1 ? 'Value Can\'t Be Empty' : null,
                  ),
                )),
                     
            Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: descriptionControler,
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    errorText: _validate2 ? 'Value Can\'t Be Empty' : null,
                  ),
                )),

            Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: directionControler,
                  decoration: InputDecoration(
                    labelText: 'Dirección',
                    errorText: _validate3 ? 'Value Can\'t Be Empty' : null,
                  ),
                )),

                  Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: telephoneControler,
                  decoration: InputDecoration(
                    labelText: 'Teléfono',
                    
                  ),
                )),


                 Container(
      padding: EdgeInsets.symmetric(vertical:8.0, horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
           Checkbox(
              value: checkBoxValue,
              activeColor: Colors.blue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                  if(newValue==true){
                    checkbox='Activo';
                  }
                  else{
                    checkbox='No activo';
                  }
                  
                });
                
              }),
              Text('¿Activo?', style: TextStyle(color: Colors.black)),
        ],
      ),
    ),

             
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () async {
                setState(() {
                  if (nameControler.text.isEmpty) {
                    _validate1 = true;
                  } else if (descriptionControler.text.isEmpty) {
                    _validate2 = true;
                  } 
                    else if (directionControler.text.isEmpty) {
                    _validate3 = true;
                  }
                  else {
                    _validate1 = false;
                    _validate2 = false;
                      _validate3 = false;
                   
                  }
                });
                if (!_validate1 && !_validate2 && !_validate3) {
                  

                   Proveedor newPost = Proveedor(
                  nombre: nameControler.text,
                  descripcion: descriptionControler.text,
                  direccion: directionControler.text,
                  telefono: telephoneControler.text,
                  estado: checkbox);
              var statusCode= await createObjetoNoJson(globals.urlCrearProveedor, newPost.toMap(), globals.token);
               
                   await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Mensaje de alerta'),
                          content: Text(
                              '¡Proveedor agregado!\n¿Quiere agregar otro?'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GoalList(token: globals.token)),
                                );
                              },
                            ),
                            FlatButton(
                              child: Text('Sí'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                nameControler.clear();
                                descriptionControler.clear();
                                directionControler.clear();
                                telephoneControler.clear();
                              },
                            ),
                          ],
                        );
                      });
                 
                  
                      
                     
                }
              },
              child: const Text("Agregar proveedor"),
            )
          ],
        ));

  }
}
