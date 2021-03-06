

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

bool isNumeric(String s){

  if (s.isEmpty) return false;
    
  final n = num.tryParse(s);

  return (n == null) ? false : true;

}

void mostrarAlerta(BuildContext context, String titulo, String mensaje){

  showDialog(
    context: context,
    builder: (context){
      return FadeIn(
        child: AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: ()=> Navigator.of(context).pop(),
            )
          ],
        ),
        duration: Duration(milliseconds: 250),
      );
    }
  );


}
