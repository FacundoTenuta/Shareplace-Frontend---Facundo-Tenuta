import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shareplace_flutter/src/pages/login_page.dart';
import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:shareplace_flutter/src/providers/publication_provider.dart';
import 'package:shareplace_flutter/src/providers/user_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
        ChangeNotifierProvider<PublicationProvider>(create: (context) => PublicationProvider()),
      ],
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

