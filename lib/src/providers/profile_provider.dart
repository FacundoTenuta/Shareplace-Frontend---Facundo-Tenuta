import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:async';
import 'package:shareplace_flutter/src/models/user_model.dart';


class UserProvider{

  bool _cargando = false;

  Future<User> cargarRequestionsRecibidas(int userId, int page) async {

    if (_cargando){
      return null;
    }

    _cargando = true;

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/$userId');

    final resp = await _procesarRespuesta(url);

    // _requestions.addAll(resp);

    // requestionsSink(_requestions);
    
    _cargando = false;

    return resp;

  }

  // final _requestionsStreamController = StreamController<List<User>>.broadcast();

  //   Stream<List<User>> get requestionsStream => _requestionsStreamController.stream;

  //   Function(List<User>) get requestionsSink => _requestionsStreamController.sink.add;

  //   void disposeStreams(){
  //   _requestionsStreamController?.close();
  // }




  Future<User> _procesarRespuesta(Uri url) async {

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    print(decodedData);

    final publications = User.fromJson(decodedData['data']);

    return publications;

  }

}