import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/bloc/provider.dart';

import 'package:shareplace_flutter/src/pages/login_page.dart';
import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:shareplace_flutter/src/routes/routes.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Shareplace',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: getApplicationRoutes(),
        onGenerateRoute: (settings){
          return MaterialPageRoute(
            builder: (BuildContext context) => LoginPage()
          );
        }
      ),
    );  
  }
}

