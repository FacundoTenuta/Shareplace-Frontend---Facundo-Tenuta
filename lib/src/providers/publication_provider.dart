
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shareplace_flutter/src/models/publication_model.dart';
import 'dart:core';
import 'dart:async';


class PublicationProvider{

  // final _publicationsController = BehaviorSubject<List<Publication>>();

  int _lastPage;
  bool _cargando = false;

  List<Publication> _publications = new List();

  Future<List<Publication>> cargarPublications(int page) async {

    if (_cargando){
      return [];
    }

    _cargando = true;

    // _publicationsPage++;

    // print('Cargando siguientes...');

    

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/publications', {
      'page'    : page.toString(),
    });

    final resp = await _procesarRespuesta(url);

    // final resp = await _procesarRespuesta('http://10.0.2.2/shareplace-backend---facundo-tenuta/public/api/publications');

    _publications.addAll(resp);

    publicationsSink(_publications);
    
    _cargando = false;

    return resp;

  }

  Future<List<Publication>> cargarMisPublications(int userId, int page) async {

    if (_cargando){
      return [];
    }

    _cargando = true;
    // print('Cargando siguientes...');

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/$userId/publications', {
      'page'    : page.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _publications.addAll(resp);

    publicationsSink(_publications);
    
    _cargando = false;

    return resp;

  }


  final _publicationsStreamController = StreamController<List<Publication>>.broadcast();

    Stream<List<Publication>> get publicationsStream => _publicationsStreamController.stream;

    Function(List<Publication>) get publicationsSink => _publicationsStreamController.sink.add;

    void disposeStreams(){
    _publicationsStreamController?.close();
  }



  Future<List<Publication>> buscarPublication(String query) async {

    final url = Uri.https('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/search', {
      'busqueda'   : query,
    });

    return await _procesarRespuesta(url);

  }

  Future<List<Publication>> _procesarRespuesta(Uri url) async {

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    // print(decodedData);

    final publications = Publications.fromJsonList(decodedData['data']);

    _lastPage = decodedData['current_page'];
    print(_lastPage);

    return publications.items;

  }


}