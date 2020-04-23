import 'package:flutter/material.dart';
import 'package:myapp/globals/global.dart' as globals;
class RadioButton extends StatefulWidget {
  @override
  _RadioButton createState() => _RadioButton();
}

class _RadioButton extends State<RadioButton> {
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:8.0, horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
           Checkbox(
              value: checkBoxValue,
              activeColor: Colors.green,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                  if(newValue==true){
                    globals.estado='Activo';
                  }
                  else{
                    globals.estado='No activo';
                  }
                  
                });
                
              }),
              Text('¿Activo?', style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
