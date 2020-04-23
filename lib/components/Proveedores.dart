import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/components/ListaDeProveedores.dart';
import 'package:myapp/components/ProductoDetalles.dart';
import 'package:myapp/globals/item.dart';
import 'package:myapp/globals/global.dart' as globals;
import 'package:myapp/components/addProveedor.dart';

class Proveedores extends StatelessWidget {
  Widget build(BuildContext context) {
    dynamic color = Colors.blue;
    return Scaffold(
      appBar: AppBar(
        title: Text('Proveedores'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Wrap(
          spacing: 17,
          runSpacing: 17,
          children: <Widget>[
            Item(
              title: 'Agregar Proveedor',
              icon: Icons.add_box,
              color: color,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgregarProveedores()),
                );
              },
            ),
            Item(
              title: 'Mostrar proveedores',
              icon: Icons.shopping_basket,
              color: color,
              onTap: () {
                Navigator.push(
                   context,
                 MaterialPageRoute(builder: (context) => MostrarProveedores(
                  url: globals.urlObtenerProveedores,
                   title: 'Lista de proveedores',
                   objeto: 3
                   )),
                );
              },
            ),
            Item(title: 'Ver reportes', icon: Icons.report, color: color),
            //Item(title: 'Sales', icon: Icons.show_chart, color: color)
          ],
        ),
      ),
    );
  }
}
