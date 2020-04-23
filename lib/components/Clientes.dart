import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/globals/item.dart';
class Clientes extends StatelessWidget{

  Widget build(BuildContext context){
    dynamic color=Colors.blue;
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        
        ),
        body: Center(
          child: Wrap(
            spacing: 17,
            runSpacing: 17,
            children: <Widget>[
              Item(title: 'Expend', icon: Icons.home, color: color),
              Item(title: 'Collection', icon: Icons.star, color: color),
              Item(
                  title: 'Incomes',
                  icon: Icons.monetization_on,
                  color: color),
              Item(title: 'Sales', icon: Icons.show_chart, color: color)
            ],
          ),
        ),
    );


  }


}