import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/components/radio.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/services/api.dart';
import 'package:myapp/components/datePicker.dart';
import 'package:myapp/components/ListaDeProductos.dart';
import 'package:myapp/globals/user.dart';
import 'package:myapp/globals/global.dart' as globals;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;



class ProveedorDetalles extends StatefulWidget {
  final List<dynamic> values;
   final int index;
   final token;
  final Future<Proveedor> post;
  ProveedorDetalles({Key key, this.post, @required this.token,  this.values, this.index}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Form(token,values, index);
  }
}

class _Form extends State<StatefulWidget> {
  final List<dynamic> values;
   final int index;
  final token;
  _Form(this.token,this.values, this.index);

  
    bool _validate1 = false, _validate2 = false, _validate3 = false;
   
  TextEditingController nameControler = TextEditingController();
  TextEditingController descriptionControler = TextEditingController();
  TextEditingController directionControler = TextEditingController();
  TextEditingController telephoneControler = TextEditingController();
  TextEditingController statusControler = TextEditingController();
  String checkbox='';
  bool checkBoxValue = false;
  bool flag=false;
 
  setData(){
   
      nameControler.text= values[index].nombre;
       descriptionControler.text= values[index].descripcion;
        directionControler.text= values[index].direccion;
       telephoneControler.text= values[index].telefono;
   }
  
  @override
  Widget build(BuildContext context) {
   if(!flag){
     setData();
   }
    return Scaffold(
        appBar: AppBar(
          title: Text('Editar proveedor'),
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
              var statusCode= await actualizarObjetoNoJson(values[index].id,globals.urlActualizarProveedor, newPost.toMap(), globals.token);
               
                   await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Mensaje de alerta'),
                          content: Text(
                              '¡Proveedor actualizado!\n¿Desea permanecer aquí?'),
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
