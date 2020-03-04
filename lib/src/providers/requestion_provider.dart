
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:async';

import 'package:shareplace_flutter/src/models/requestion_model.dart';
import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';


class RequestionProvider{

  int _lastPage;
  bool _cargando = false;

  final _prefs = new PreferenciasUsuario();

  List<Requestion> _requestions = new List();

  Future<List<Requestion>> cargarRequestionsRecibidas(int userId, int page) async {

    if (_cargando){
      return [];
    }

    _cargando = true;


    

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/$userId/requestionsReceived', {
      'page'    : page.toString(),
    });

    final resp = await _procesarRespuesta(url);


    _requestions.addAll(resp);

    // requestionsSink(_requestions);
    
    _cargando = false;

    return resp;

  }

  Future<List<Requestion>> cargarRequestionsEnviadas(int userId, int page) async {

    if (_cargando){
      return [];
    }

    _cargando = true;

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/$userId/requestionsSent', {
      'page'    : page.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _requestions.addAll(resp);

    // requestionsSink(_requestions);
    
    _cargando = false;

    return resp;

  }

  Future<List<Requestion>> cargarLoans(int userId, int page) async {

    if (_cargando){
      return [];
    }

    _cargando = true;

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/$userId/loans', {
      'page'    : page.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _requestions.addAll(resp);

    // requestionsSink(_requestions);
    
    _cargando = false;

    return resp;

  }

  Future<List<Requestion>> cargarLoansHistoric(int userId, int page) async {

    if (_cargando){
      return [];
    }

    _cargando = true;

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/$userId/loansHistoric', {
      'page'    : page.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _requestions.addAll(resp);

    // requestionsSink(_requestions);
    
    _cargando = false;

    return resp;

  }


  // final _requestionsStreamController = StreamController<List<Requestion>>.broadcast();

  //   Stream<List<Requestion>> get requestionsStream => _requestionsStreamController.stream;

  //   Function(List<Requestion>) get requestionsSink => _requestionsStreamController.sink.add;

  //   void disposeStreams(){
  //   _requestionsStreamController?.close();
  // }




  Future<List<Requestion>> _procesarRespuesta(Uri url) async {

    final resp = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'bearer ' + _prefs.token.toString()});
    final decodedData = json.decode(resp.body);


    final publications = Requestions.fromJsonList(decodedData['data']);

    _lastPage = decodedData['current_page'];

    return publications.items;

  }

  Future<String> eliminarSolicitud(int id) async {

    if (_cargando){
      return null;
    }

    _cargando = true;

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/requestions/$id');

    final info = await http.delete(url, headers: {HttpHeaders.authorizationHeader: 'bearer ' + _prefs.token.toString()});
        
    _cargando = false;

    return info.statusCode.toString();

  }

  Future<String> transformarPrestamo(int id) async {

    if (_cargando){
      return null;
    }

    _cargando = true;

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/loans/$id', {
      'isLoan'          : '1',
      'startDate'       : DateTime.now().toString(),
      'active'          : '1',
    });

    final info = await http.put(url, headers: {HttpHeaders.authorizationHeader: 'bearer ' + _prefs.token.toString()});
        
    _cargando = false;

    return info.statusCode.toString();

  }

  Future<String> finalizarPrestamo(int id) async {

    if (_cargando){
      return null;
    }

    _cargando = true;

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/loans/$id', {
      'active'          : '0',
      'endDate'         : DateTime.now().toString(),
      'isLoan'          : '1',
    });

    final info = await http.put(url, headers: {HttpHeaders.authorizationHeader: 'bearer ' + _prefs.token.toString()});
        
    _cargando = false;

    return info.statusCode.toString();

  }


}