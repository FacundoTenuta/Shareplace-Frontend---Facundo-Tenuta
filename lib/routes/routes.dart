






import 'package:flutter/material.dart';
import 'package:shareplace_flutter/pages/inicio_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    'inicio' : (BuildContext context) => InicioPage(),
  };
}
