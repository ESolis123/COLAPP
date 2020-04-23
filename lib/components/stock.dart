import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Stock extends StatefulWidget {
  @override
  _Stock createState() => _Stock();
}

class _Stock extends State<Stock> {
int _n = 0;

void add() {
  setState(() {
    _n++;
  });
}
  
void minus() {
  setState(() {
    if (_n != 0) 
      _n--;
  });
}
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new FloatingActionButton(
              mini: true ,
              heroTag: 'btn1',
              onPressed: add,
              child: new Icon(Icons.add, color: Colors.white,),
              backgroundColor: Colors.blue,),

            new Text('$_n',
                style: new TextStyle(fontSize: 30.0)),

            new FloatingActionButton(
              mini: true,
              heroTag: 'btn2',
              onPressed: minus,
              child: new Icon(
               const IconData(0xe15b, fontFamily: 'MaterialIcons'),
                 color: Colors.white),
              backgroundColor: Colors.blue,),
          ],
        ),
    )); 
    
    
    
    
}
}