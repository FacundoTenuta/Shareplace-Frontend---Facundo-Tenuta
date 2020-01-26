






import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/pages/inicio_page.dart';
import 'package:shareplace_flutter/src/pages/login_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    'inicio'  : (BuildContext context) => InicioPage(),
    'login'   : (BuildContext context) => LoginPage(),
  };
}
