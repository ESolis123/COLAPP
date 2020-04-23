import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/components/radio.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/services/api.dart';
import 'package:myapp/components/datePicker.dart';
import 'package:myapp/components/price.dart';
import 'package:myapp/globals/user.dart';
import 'package:myapp/globals/global.dart' as globals;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
class AddProduct extends StatelessWidget {
   
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       body:  FutureBuilder<dynamic>(
        future:
            fetchPost(http.Client(), globals.urlObtenerTiposProductos,globals.token,2),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? Form(token:globals.token, tiposProductos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );

  }
}

class Form extends StatefulWidget {
  final List<TiposProductos> tiposProductos;
  final token;
  final Future<Producto> post;
  Form({Key key, this.post, @required this.token, @required this.tiposProductos}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Form(token,tiposProductos);
  }
}

class _Form extends State<StatefulWidget> {
   final List<TiposProductos> tiposProductos;
  final token;
  _Form(this.token, this.tiposProductos);
  List <String> categorias=[];
String dropdownValue='Huevos';
  

  @override
void initState() {
super.initState();
for (var tipo in tiposProductos){
      if(tipo.nombre!=""){
         categorias.add(tipo.nombre);
          
      }
     
    }
}

  bool _validate1 = false, _validate2 = false, _validate3 = false, _validate4 = false;
   
  TextEditingController nameControler = TextEditingController();
  TextEditingController descriptionControler = TextEditingController();
  TextEditingController categoryControler = TextEditingController();
  TextEditingController stockControler = TextEditingController();
  TextEditingController precioCompraControler = TextEditingController();
  TextEditingController precioVentaControler = TextEditingController();
  String checkbox='';
  bool checkBoxValue = false;
  buscarValor(nombre){
    int index=0;
    for (var tipo in tiposProductos){
      if(nombre==tipo.nombre){
        index=tipo.id;
      }
    }
    return index;
  }

  @override
  Widget build(BuildContext context) {
   
  
    return Scaffold(
        appBar: AppBar(
          title: Text('Agregar producto'),
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
                    labelText: 'Nombre del producto',
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
           
            DatePicker(title: 'Fecha de elaboración', tipo: 1),
            DatePicker(title: 'Fecha de vencimiento', tipo: 2),

            Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  
                  decoration: InputDecoration(
                    labelText: 'Precio de compra',
                    errorText: _validate3 ? 'Value Can\'t Be Empty' : null,
                  ),
                  //validator: ,
                  
                  controller: precioCompraControler,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    // Fit the validating format.
                    //fazer o formater para dinheiro
                    //CurrencyInputFormatter(),
                    
                  ],
                  keyboardType: TextInputType.number,
                )),

                Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  
                  decoration: InputDecoration(
                    labelText: 'Precio de venta',
                    errorText: _validate4 ? 'Value Can\'t Be Empty' : null,
                  ),
                  //validator: ,
                  
                  controller: precioVentaControler,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    // Fit the validating format.
                    //fazer o formater para dinheiro
                    //CurrencyInputFormatter(),
                    
                  ],
                  keyboardType: TextInputType.number,
                )),
            
            Container(
              padding: EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue,
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.blue, fontSize: 16),
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: categorias.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: stockControler,
                  decoration: InputDecoration(
                    labelText: 'Cantidad disponible',
                    
                  ),
                  inputFormatters: <TextInputFormatter>[
    WhitelistingTextInputFormatter.digitsOnly
], 
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
                  } else {
                    _validate1 = false;
                    _validate2 = false;
                  }
                });
                if (!_validate1 && !_validate2 ) {
                  var formatter = DateFormat('yyyy-MM-dd'); 
                  var precioCompra= precioCompraControler.text;
                  var precioVenta=precioVentaControler.text; 
                  var stock=stockControler.text;
                  var estado=checkbox;
                  var id=buscarValor(dropdownValue).toString();
                  var nombre=nameControler.text;
                  var fechaCreacion=formatter.format(globals.fechaCreacion);
                  var fechaVencimiento=formatter.format(globals.fechaVencimiento);
                  var fechaCompra=formatter.format(globals.fechaCompra);
                  var descripcion=descriptionControler.text;

                  String body='{"nombre":"$nombre","descripcion":"$descripcion",';
                  body+='"fec_elaboracion":"$fechaCreacion","fec_vencimiento":"$fechaVencimiento",';
                  body+='"fec_compra":"$fechaCompra",';
                  body+='"precio_compra":"$precioCompra",';
                  body+= '"precio_venta":"$precioVenta",';
                  body+='"stock":"$stock",';
                  body+='"status":"$estado",';
                  body+='"id_tipo_producto":$id}';
  
                  await crearObjeto(globals.urlCrearProducto, body,token);
                 
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Mensaje de alerta'),
                          content: Text(
                              '¡Producto agregado!\n¿Quiere agregar otro?'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GoalList(token: token)),
                                );
                              },
                            ),
                            FlatButton(
                              child: Text('Sí'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                nameControler.clear();
                                descriptionControler.clear();
                                stockControler.clear();
                                precioCompraControler.clear();
                                precioVentaControler.clear();
                                stockControler.clear();
                              },
                            ),
                          ],
                        );
                      });
                      
                     
                }
              },
              child: const Text("Agregar producto"),
            )
          ],
        ));

  }
}
