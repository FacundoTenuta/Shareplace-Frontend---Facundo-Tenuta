
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:async';

import 'package:shareplace_flutter/src/models/requestion_model.dart';


class RequestionProvider{

  int _lastPage;
  bool _cargando = false;

  List<Requestion> _requestions = new List();

  Future<List<Requestion>> cargarRequestionsRecibidas(int userId, int page) async {

    if (_cargando){
      return [];
    }

    _cargando = true;


    print('Cargando siguientes...');

    

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/$userId/requestionsReceived', {
      'page'    : page.toString(),
    });

    final resp = await _procesarRespuesta(url);


    _requestions.addAll(resp);

    requestionsSink(_requestions);
    
    _cargando = false;

    return resp;

  }

  Future<List<Requestion>> cargarRequestionsEnviadas(int userId, int page) async {

    if (_cargando){
      return [];
    }

    _cargando = true;
    print('Cargando siguientes...');

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/$userId/requestionsSent', {
      'page'    : page.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _requestions.addAll(resp);

    requestionsSink(_requestions);
    
    _cargando = false;

    return resp;

  }

  Future<List<Requestion>> cargarLoans(int userId, int page) async {

    if (_cargando){
      return [];
    }

    _cargando = true;
    print('Cargando siguientes...');

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/$userId/loans', {
      'page'    : page.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _requestions.addAll(resp);

    requestionsSink(_requestions);
    
    _cargando = false;

    return resp;

  }

  Future<List<Requestion>> cargarLoansHistoric(int userId, int page) async {

    if (_cargando){
      return [];
    }

    _cargando = true;
    print('Cargando siguientes...');

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/$userId/loans', {
      'page'    : page.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _requestions.addAll(resp);

    requestionsSink(_requestions);
    
    _cargando = false;

    return resp;

  }


  final _requestionsStreamController = StreamController<List<Requestion>>.broadcast();

    Stream<List<Requestion>> get requestionsStream => _requestionsStreamController.stream;

    Function(List<Requestion>) get requestionsSink => _requestionsStreamController.sink.add;

    void disposeStreams(){
    _requestionsStreamController?.close();
  }




  Future<List<Requestion>> _procesarRespuesta(Uri url) async {

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    print(decodedData);

    final publications = Requestions.fromJsonList(decodedData['data']);

    _lastPage = decodedData['current_page'];
    print(_lastPage);

    return publications.items;

  }


}