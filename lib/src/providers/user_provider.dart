import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';

class UserProvider with ChangeNotifier {

  bool _cargando = false;

  final _prefs = new PreferenciasUsuario();

  User _user;

  User get getUser {
    return _user;
  }

  void setUser( user ){
    this._user = user;

    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String dni, String password) async{


    final resp = await http.post(

      'http://10.0.2.2/shareplace-backend---facundo-tenuta/public/api/auth/login',

      body: {
        "dni": dni,
        "password": password
      }

    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    // print(decodedResp);

    if (decodedResp.containsKey('access_token')) {

      _prefs.token = decodedResp['access_token'];

      _prefs.user = decodedResp['user']['id'];

      // user = decodedResp['user'];

      User user = User.fromJson(decodedResp['user']);

      setUser(user);
      // userProvider.setUser = user;
      
      return {'ok': true, 'token': decodedResp['access_token']};

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

    setUser(resp);
    
    _cargando = false;

    return resp;
  }

  Future<User> _procesarRespuesta(Uri url) async {

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    // print(decodedData);

    final user = User.fromJson(decodedData['data']);
    return user;

  }

  editarUsuario(String _name, String _lastName, String _mail, String _phone, String _description, File _image) async {

    // Dio dio = new Dio(
    // //   // BaseOptions(
    // //   //   headers: {contentType: "application/form-data"},
    // //   // )
    // );
    FormData formData = new FormData(); 

    if (_cargando){
      return null;
    }

    _cargando = true;

    if (_image != null) {
      formData.files.add(MapEntry("image", await MultipartFile.fromFile(_image.path)));
    }

    

    formData.fields.add(MapEntry("name", _name),);
    formData.fields.add(MapEntry("lastName", _lastName),);
    formData.fields.add(MapEntry("email", _mail),);
    formData.fields.add(MapEntry("phone", _phone),);
    formData.fields.add(MapEntry("description", _description),);
    formData.fields.add(MapEntry("_method", "put"),);

    final Response<Map> response = await new Dio().post(
      'http://10.0.2.2/shareplace-backend---facundo-tenuta/public/api/users/${_prefs.user}',
      options: Options(
        headers: {
          "Content-Type": "application/json",
        }
      ),
      data: formData
    );

    // this.cargarUsuario(_prefs.user);

    // User user = this.getUser;
    // user.image = _image;

    User user = User.fromJson(response.data['data']);


    // setUser = user;

    setUser(user);
        
    _cargando = false;

  }


  Future<User> obtenerUsuario(int user) async{

    if (_cargando){
      return null;
    }

    _cargando = true;

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/$user');

    final resp = await _procesarRespuesta(url);
    
    _cargando = false;

    return resp;
  }





}