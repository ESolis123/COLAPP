import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/components/ProveedorDetalles.dart';
import 'package:myapp/components/ListaDeProductos.dart';
import 'package:myapp/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/globals/global.dart' as globals;
import 'package:myapp/globals/user.dart' ;
class MostrarProveedores extends StatefulWidget {
  @required final String url;
  @required final String title;
  @required final int objeto;

  const MostrarProveedores({Key key, @required this.url, this.title, this.objeto}): super(key: key);
  @override
  _MostrarProveedores createState() =>_MostrarProveedores(url: url, title: title, objeto: objeto);
}

class _MostrarProveedores extends State<MostrarProveedores> {
  final String url;
  final String title;
  final int objeto;
  _MostrarProveedores({@required this.url, @required this.title, @required this.objeto});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: FutureBuilder<dynamic>(
          future: fetchPost(http.Client(), globals.urlObtenerProveedores, globals.token,
              objeto), // a previously-obtained Future<String> or null
          builder: (BuildContext context, snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              List<dynamic> values = snapshot.data;
              children = <Widget>[
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: values.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        if (values.length != 0) {
                          return GestureDetector(
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProveedorDetalles(values: values, index: index, token: globals.token
                                           )),
                                  ),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 16.0),
                                child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0x802196F3),
                                              blurRadius: 20,
                                              offset: Offset(0, 10))
                                        ]),
                                    child: childDetalle(values, index)),
                              ));
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(top: 0),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ];
            } else {
              children = <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Esperando resultados...'),
                )
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            );
          }),
    );
  }

  Widget childDetalle(List<dynamic> values, int index) {
    return Row(children: <Widget>[
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                  child: Text(
                values[index].nombre,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
            ),
            Container(
                child: Text(
              values[index].descripcion,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
          ])),
      Column(
        children: <Widget>[

          IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.mode_edit),
              color: Colors.blue,
              iconSize: 30,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProveedorDetalles(values: values, token:globals.token, index: index),
                ));
              }),

          IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.delete_forever),
              color: Colors.blue,
              iconSize: 30,
              onPressed: () async {
                values.remove(values[index].id);
                values.join(', ');
                await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Title(
                          title: 'Eliminar proveedor',
                          child: Text(
                              '¿Está seguro de que desea eliminarlo?'),
                          color: Colors.black,
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('No'),
                            onPressed: () async {
                              Navigator.of(context).pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text('Yes'),
                            onPressed: () async {
                            Proveedor newPost = Proveedor(
                  nombre: values[index].nombre,
                  descripcion: values[index].descripcion,
                  direccion: values[index].direccion,
                  telefono: values[index].telefono,
                  estado: 'No activo'
                  );
   


                 
                              await actualizarObjeto(
                                    values[index].id, newPost.toMap(), globals.urlActualizarProveedor, globals.token);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MostrarProveedores(url: url, title:title, objeto: objeto)),
                                );

                            },
                          ),
                        ],
                      );
                    });
              })
        ],
      )
    ]);
  }
}
