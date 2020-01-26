import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';

class UsuarioProvider{

  final _prefs = new PreferenciasUsuario();


  Future<Map<String, dynamic>> login(String dni, String password) async{

    // final publis = await http.get(

    //   'http://10.0.2.2/shareplace-backend---facundo-tenuta/public/api/publications',

    // );

    // Map<String, dynamic> decodedResp1 = json.decode(publis.body);

    // print(decodedResp1);

    final resp = await http.post(

      'http://10.0.2.2/shareplace-backend---facundo-tenuta/public/api/auth/login',

      body: {
        "dni": dni,
        "password": password
      }

    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if (decodedResp.containsKey('access_token')) {

      _prefs.token = decodedResp['access_token'];

      // Map<String, dynamic> decodedUser = json.decode(decodedResp['user'].body);
      
      return {'ok': true, 'token': decodedResp['access_token'], 'user': decodedResp['user']};

    }else{

      return {'ok': false, 'mensaje': decodedResp['error']};
      
    }
  }


  // Future<Map<String, dynamic>> nuevoUsuario(String email, String password) async {

    
  //   final authData = {
  //     'email' : email,
  //     'password' : password,
  //     'returnSecureToken' : true,
  //   };

  //   final resp = await http.post(

  //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
  //     body: json.encode(authData),

  //   );

  //   Map<String, dynamic> decodedResp = json.decode(resp.body);

  //   print(decodedResp);

  //   if (decodedResp.containsKey('idToken')) {

  //     // _prefs.token = decodedResp['idToken'];

  //     return {'ok': true, 'token': decodedResp['idToken']};
  //   }else{
  //     return {'ok': true, 'mensaje': decodedResp['error']['message']};
  //   }

  // }

}

