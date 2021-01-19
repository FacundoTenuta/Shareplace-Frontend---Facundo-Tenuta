
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shareplace_flutter/src/models/publication_model.dart' as model;
import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';
// import 'dart:core';
// import 'dart:async';


class PublicationProvider with ChangeNotifier {

  // final _publicationsController = BehaviorSubject<List<Publication>>();

  final _prefs = new PreferenciasUsuario();

  int _lastPage;
  bool _cargando = false;

  // List<Publication> _publications = new List();

  model.Publication _publication, _publicationReal;

  model.Publication get getPublication {
    return _publication;
  }

  void setPublication( publication ){
    this._publication = publication;

    notifyListeners();
  }

  model.Publication get getPublicationReal {
    return _publicationReal;
  }

  void setPublicationReal( publicationReal ){
    this._publicationReal = publicationReal;

    notifyListeners();
  }

  String _title, _description, _principalImage;

  // model.Image _principalImage;

  int _id;

  List<model.Image> _images;
  List<model.Image> _currentImages;
  List<String> _conditions;
  List<int> _deletedImages;

  List<File> _newImages;

  String get getTitle{
    return this._title;
  }

  int get getId{
    return this._id;
  }

  void setTitle( title ){
    this._title = title;
    notifyListeners();
  }

  String get getDescription {
    return this._description;
  }

  void setDescription( description ){
    this._description = description;
    notifyListeners();
  }

  String get getprincipalImage {
    return this._principalImage;
  }

  void setPrincipalImage( principalImage ){
    this._principalImage = principalImage;
    notifyListeners();
  }

  List<model.Image> get getImages {
    return this._images;
  }

  void setImages( images ){
    this._images = images;
    notifyListeners();
  }

  List<model.Image> get getCurrentImages {
    return this._currentImages;
  }

  void setCurrentImages( images ){
    this._currentImages = images;
    notifyListeners();
  }

  List<File> get getNewImages {
    return this._newImages;
  }

  void setNewImages( newImages ){
    this._newImages = newImages;
    notifyListeners();
  }

  List<String> get getConditions {
    return this._conditions;
  }

  void setConditions( conditions ){
    this._conditions = conditions;
    notifyListeners();
  }



  Future<List<model.Publication>> cargarPublications(int page) async {

    if (_cargando){
      return [];
    }

    _cargando = true;    

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/publications', {
      'page'    : page.toString(),
    });

    final resp = await _procesarRespuesta(url);
    
    _cargando = false;

    return resp;

  }

  Future<List<model.Publication>> cargarMisPublications(int userId, int page) async {

    if (_cargando){
      return [];
    }

    _cargando = true;
    // print('Cargando siguientes...');

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/$userId/publications', {
      'page'    : page.toString(),
    });

    final resp = await _procesarRespuesta(url);

    // _publications.addAll(resp);

    // publicationsSink(_publications);
    
    _cargando = false;

    return resp;

  }



  Future<List<model.Publication>> buscarPublication(String query) async {

    final url = Uri.https('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/users/search', {
      'busqueda'   : query,
    });

    return await _procesarRespuesta(url);

  }

  Future<List<model.Publication>> _procesarRespuesta(Uri url) async {

    final resp = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'bearer ' + _prefs.token.toString()});
    final decodedData = json.decode(resp.body);

    // print(decodedData);

    final publications = model.Publications.fromJsonList(decodedData['data']);

    _lastPage = decodedData['current_page'];
    
    return publications.items;

  }

  void setArguments(int id, String title, String principalImage, List<model.Image> images, String description, List<model.Condition> conditions) {

    List<String> aux2 = new List(); 


    for (var i = 0; i < conditions.length; i++) {
      aux2.add(conditions[i].name);
    }

    this.setNewImages(List<File>());
    this._deletedImages = List();

    this._id = id;
    this._title = title;
    if (principalImage != 'FondoDePublicacion.jpg') {
      
    }
    this._principalImage = principalImage;

    this.setCurrentImages(List<model.Image>());
    this.getCurrentImages.addAll(images);
    this._images = images;
    this._description = description;
    this._conditions = aux2;

    // notifyListeners();

  }

  void editarPublicacion(File imagenPrincipal) async {



    FormData formData = new FormData(); 

    if (_cargando){
      return null;
    }

    _cargando = true;


    if (imagenPrincipal != null) {
      formData.files.add(MapEntry("principalImage", await MultipartFile.fromFile(imagenPrincipal.path)));
    }

    if (_newImages.isNotEmpty) {
      for (var i = 0; i < _newImages.length; i++) {
        formData.files.add(MapEntry("images[$i]", await MultipartFile.fromFile(_newImages[i].path)));
      }
    }    

    formData.fields.add(MapEntry("title", _title),);
    // List<model.Condition> condiciones = List();
    for (var i = 0; i < _conditions.length; i++) {
      formData.fields.add(MapEntry("conditions[$i]", _conditions[i]));
      // model.Condition cond = new model.Condition();
      // cond.name = _conditions[i];
      // condiciones.add(cond);
    }

    for (var i = 0; i < _deletedImages.length; i++) {
      formData.fields.add(MapEntry("deletedImages[$i]", _deletedImages[i].toString()));
    }

    formData.fields.add(MapEntry("description", _description),);

    if (this.getprincipalImage == null) {
      formData.fields.add(MapEntry("notPrincipalImage", "1"));
    }

    formData.fields.add(MapEntry("_method", "put"),);

    var response = await new Dio().post(
      'http://10.0.2.2/shareplace-backend---facundo-tenuta/public/api/publications/$_id',
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "authorization" : "bearer " + _prefs.token.toString(),
        }
      ),
      data: formData
    );

    model.Publication real = model.Publication.fromJson(response.data['data']);
    

    this.setPublicationReal(real);
        
    _cargando = false;


  }

  void removeImage(String aux) {

    model.Image aux2 = this.getCurrentImages.firstWhere((image) => image.path == aux, orElse: () => null);

    if (aux2 != null) {
      // this._currentImages.remove(aux2);
      List<model.Image> aux = this.getCurrentImages;
      int index = aux.indexOf(aux2);
      aux.removeAt(index);
      this.setCurrentImages(aux);
    
      this._deletedImages.add(aux2.id);
    }

    

  }

  Future<String> borrarPublicacion() async{

    
    if (_cargando){
      return null;
    }

    _cargando = true;

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/publications/${this._publicationReal.id}');

    final info = await http.delete(url, headers: {HttpHeaders.authorizationHeader: 'bearer ' + _prefs.token.toString()});
        
    _cargando = false;

    return info.statusCode.toString();

  }

  Future<String> crearPublicacion(String title, String description, List<String> conditions, File principalImage, List<File> extraImages, user) async{

    FormData formData = new FormData(); 

    if (_cargando){
      return null;
    }

    _cargando = true;

    if (principalImage != null) {
      formData.files.add(MapEntry("principalImage", await MultipartFile.fromFile(principalImage.path)));
    }

    if (extraImages.isNotEmpty) {
      for (var i = 0; i < extraImages.length; i++) {
        formData.files.add(MapEntry("images[$i]", await MultipartFile.fromFile(extraImages[i].path)));
      }
    } 

    formData.fields.add(MapEntry("title", title),);

    for (var i = 0; i < conditions.length; i++) {
      formData.fields.add(MapEntry("conditions[$i]", conditions[i]));
    }

    formData.fields.add(MapEntry("description", description),);

    formData.fields.add(MapEntry("user_id", user.toString()),);

    Response info = await new Dio().post(
      'http://10.0.2.2/shareplace-backend---facundo-tenuta/public/api/publications',
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "authorization" : "bearer " + _prefs.token.toString(),
        }
      ),
      data: formData
    );

    _cargando = false;

    return info.statusCode.toString();

  }

  Future<String> cambiarEstadoPublicacion() async {

    if (_cargando){
      return null;
    }

    _cargando = true;

    bool estado = this._publicationReal.state;
    String aux;

    if (!estado) {
      aux = '1';
    }else{
      aux = '0';
    }

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/publications/${this._publicationReal.id}', {
      'state'     : aux,
      '_method'   : 'put',
    });

    final info = await http.post(url, headers: {HttpHeaders.authorizationHeader: 'bearer ' + _prefs.token.toString()});

    this.setEstado(!estado);
        
    _cargando = false;

    return info.statusCode.toString();

  }

  void setEstado(bool estado) {
    this._publicationReal.state = estado;
    notifyListeners();
  }

  Future<String> solicitarPublicacion(String motivo, DateTime desde, DateTime hasta) async{

    if (_cargando){
      return null;
    }

    _cargando = true;

    int user = _prefs.user;

    model.Publication publi = this.getPublication;

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/requestions', {
      'user'        : user.toString(),
      'publication' : publi.id.toString(),
      'title'       : publi.title,
      'reason'      : motivo,
      'fromDate'    : desde.toString(),
      'untilDate'   : hasta.toString(),
    });

    final info = await http.post(url, headers: {HttpHeaders.authorizationHeader: 'bearer ' + _prefs.token.toString()});

    _cargando = false;

    return info.statusCode.toString();

  }

  Future<model.Publication> obtenerPublicacion(int id) async {

    if (_cargando){
      return null;
    }

    _cargando = true;    

    final url = Uri.http('10.0.2.2', '/shareplace-backend---facundo-tenuta/public/api/publications/$id');

    final resp = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'bearer ' + _prefs.token.toString()});
    final decodedData = json.decode(resp.body);

    // print(decodedData);

    final publication = model.Publication.fromJson(decodedData['data']);
    
    _cargando = false;

    return publication;

  }

}