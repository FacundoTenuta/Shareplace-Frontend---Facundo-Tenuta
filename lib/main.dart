import 'package:flutter/material.dart';
import 'package:shareplace_flutter/pages/inicio_page.dart';
import 'package:shareplace_flutter/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shareplace',
      debugShowCheckedModeBanner: false,
      initialRoute: 'inicio',
      routes: getApplicationRoutes(),
      onGenerateRoute: (settings){
        return MaterialPageRoute(
          builder: (BuildContext context) => InicioPage()
        );
      }
    );  
  }
}

