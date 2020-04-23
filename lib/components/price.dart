import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:myapp/globals/global.dart' as globals;
class CurrencyInputFormatter extends TextInputFormatter {


    TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

        if(newValue.selection.baseOffset == 0){
            print(true);
            return newValue;
        }

        double value = double.parse(newValue.text);

        final formatter = NumberFormat.simpleCurrency();

        String newText = formatter.format(value/100);

        return newValue.copyWith(
            text: newText,
            selection: new TextSelection.collapsed(offset: newText.length));
    }
 
    
}


class PriceField extends State<StatefulWidget>{
  @required final String title;
   @required final int tipo;
  PriceField({this.title, this.tipo});
  TextEditingController precioController = TextEditingController();
  bool flag=false;

  void setData(){
    flag=true;
    precioController.text='0.00';
  }
  @override
Widget build (BuildContext context) {
   if(!flag){
     setData();
   }
   
   bool _validate = false;

   
    setPrice(price){ print('Precio venta:'+globals.precioVenta);
     if(tipo==1) globals.precioCompra=price;
     else globals.precioVenta=price;}
   
   return Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged:  (String newValue) {
                setState(() {
                  setPrice(newValue);
                });},

                  decoration: InputDecoration(
                    labelText: title,
                    errorText: _validate ? 'Value Can\'t Be Empty' : null,
                  ),
                  //validator: ,
                  
                  controller: precioController,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    // Fit the validating format.
                    //fazer o formater para dinheiro
                    CurrencyInputFormatter(),
                    
                  ],
                  keyboardType: TextInputType.number,
                ));
 }
}