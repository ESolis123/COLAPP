import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/components/addProduct.dart';
import 'package:myapp/globals/global.dart' as global;
import 'package:intl/intl.dart';
class DatePicker extends StatefulWidget {
  DatePicker({Key key, this.title, this.tipo, this.fechaInicial}) : super(key: key);
  final fechaInicial;
  @required final String title;
  @required final int tipo;

  @override
  _DatePicker createState() => _DatePicker(title,tipo,fechaInicial);
}

class _DatePicker extends State<DatePicker> {
  @required final int tipo;
  final String fechaInicial;
  DateTime pickedDate;
  @required
  String title;
  _DatePicker(this.title, this.tipo, this.fechaInicial);
  void initState() {
    super.initState();
    if(fechaInicial=='' || fechaInicial==null){
      pickedDate = DateTime.now();
    }
    else{
      pickedDate=DateTime.parse(fechaInicial);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: ListTile(
      contentPadding: EdgeInsets.all(8.0),
      title: Text(
        "$title: ${pickedDate.day},${pickedDate.month},${pickedDate.year},",
        style: TextStyle(color: CupertinoColors.inactiveGray),
      ),
      trailing: Icon(Icons.keyboard_arrow_down),
      onTap: _pickDate,
    ));
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (date != null) {
      setState(() {
        pickedDate = date;
       if(tipo==1){
        global.fechaCreacion=date;
      }
      else if(tipo==2){
        global.fechaVencimiento=date;
      }
      });
    }

    
  }
}
