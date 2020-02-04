import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shareplace_flutter/src/models/user_model.dart';
import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';

class UsuarioProvider{

  bool _cargando = false;

  final _prefs = new PreferenciasUsuario();


  Future<Map<String, dynamic>> login(String dni, String password) async{


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

      _prefs.user = decodedResp['user']['id'];
      
      return {'ok': true, 'token': decodedResp['access_token'], 'user': decodedResp['user']};

    }else{

      return {'ok': false, 'mensaje': decodedResp['error']};
      
    }
  }


  Future<User> cargarUsuario(int user) async{

    if (_cargando){
      return null;
    }

    _cargando = true;

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/$user');

    final resp = await _procesarRespuesta(url);

    // _requestions.addAll(resp);

    // requestionsSink(_requestions);
    
    _cargando = false;

    return resp;
  }

  Future<User> _procesarRespuesta(Uri url) async {

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    print(decodedData);

    final user = User.fromJson(decodedData['data']);

    return user;

  }

  editarUsuario(String _name, String _lastName, String _mail, String _phone, String _description) async {

    if (_cargando){
      return null;
    }

    _cargando = true;

    print('edita?');

    print(_name);
    print(_lastName);
    print(_mail);
    print(_phone);
    print(_description);

    final resp = await http.put(

      'http://10.0.2.2/shareplace-backend---facundo-tenuta/public/api/users/${_prefs.user}',

      headers: {"Content-Type": "application/x-www-form-urlencoded"},

      body: {
        "name": _name,
        "lastName": _lastName,
        'email': _mail,
        'phone': _phone,
        'description': _description,
      }

    );

    print('parece q si');

    // final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/$user');

    // final resp = await _procesarRespuesta(url);

    // _requestions.addAll(resp);

    // requestionsSink(_requestions);
    
    _cargando = false;

    // return resp;

  }
  

}

