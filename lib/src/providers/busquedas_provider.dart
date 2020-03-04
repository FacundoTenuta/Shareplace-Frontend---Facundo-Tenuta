import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shareplace_flutter/src/models/publication_model.dart';
import 'dart:core';
import 'dart:async';

import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';


class BusquedasProvider{

  int _lastPage;
  bool _cargando = false;

  final _prefs = new PreferenciasUsuario();

  // List<Requestion> _requestions = new List();

  Future<List<Publication>> buscarPublication(String dato, int page) async {

    if (_cargando){
      return [];
    }

    _cargando = true;

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/publications/search', {
      'busqueda'    : dato,
      'page'    : page.toString(),
    });

    final resp = await _procesarRespuesta(url);
    
    _cargando = false;

    return resp;

  }

  Future<List<Publication>> _procesarRespuesta(Uri url) async {

    final resp = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'bearer ' + _prefs.token.toString()});
    final decodedData = json.decode(resp.body);


    final respuesta = Publications.fromJsonList(decodedData['data']);

    _lastPage = decodedData['current_page'];

    return respuesta.items;

  }


}