import 'package:flutter/material.dart';
import 'package:myapp/components/Productos.dart';
import 'package:myapp/components/Prestamos.dart';
import 'package:myapp/components/Usuarios.dart';
import 'package:myapp/components/Proveedores.dart';
import 'package:myapp/components/Clientes.dart';
import 'package:myapp/components/Delivery.dart';
import 'package:myapp/components/Permisos.dart';
import 'package:myapp/globals/item.dart';
class GoalList extends StatefulWidget {
  final token;
  final dateDay;
  
  GoalList({Key key, @required this.token, this.dateDay}) : super(key: key);

  @override
  GoalListState createState() {
    return new GoalListState();
  }
}

class GoalListState extends State<GoalList> {
  dynamic color=Colors.blue;
  sendToPage(i) {
    switch (i) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Productos()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Proveedores()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Usuarios()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Clientes()));
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Prestamos()));
        break;
      case 5:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Delivery()));
        break;
      case 6:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Permisos()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Inicio'),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            
            children: <Widget>[
              DrawerHeader(
               
                child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 20,  ),textAlign: TextAlign.center,),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              Customizable(Icons.shopping_cart, 'Productos', ()=>{sendToPage(0)} ),
              Customizable(Icons.shop_two, 'Proveedores',  ()=>{sendToPage(1)}),
              Customizable(Icons.pan_tool, 'Empleados',  ()=>{sendToPage(2)}),
              Customizable(Icons.people, 'Clientes',  ()=>{sendToPage(3)}),
              Customizable(Icons.payment, 'Prestamos',  ()=>{sendToPage(4)}),
              Customizable(Icons.send, 'Delivery',  ()=>{sendToPage(5)}),
              Customizable(Icons.edit_attributes, 'Permisos', ()=>{sendToPage(6)}),
            ],
          ),
        ),
         
        
        );
  }
}

class Customizable extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  Customizable(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
          child: InkWell(
            onTap: onTap,
            child: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(icon),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(text, style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right),
                  ],
                )),
          ),
        ));
  }
}
