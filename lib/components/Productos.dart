import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/components/ListadeProductos.dart';
import 'package:myapp/components/ProductoDetalles.dart';
import 'package:myapp/globals/item.dart';
import 'package:myapp/globals/global.dart' as globals;
import 'package:myapp/components/addProduct.dart';

class Productos extends StatelessWidget {
  Widget build(BuildContext context) {
    dynamic color = Colors.blue;
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Wrap(
          spacing: 17,
          runSpacing: 17,
          children: <Widget>[
            Item(
              title: 'Agregar Producto',
              icon: Icons.add_box,
              color: color,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                );
              },
            ),
            Item(
              title: 'Mostrar productos',
              icon: Icons.shopping_basket,
              color: color,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MostrarProductos(
                    url: globals.urlObtenerProductos,
                    title: 'Lista de productos',
                    objeto: 1
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
