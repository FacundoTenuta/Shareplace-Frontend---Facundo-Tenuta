import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/models/argumentos_other_profile_model.dart';
import 'package:shareplace_flutter/src/models/publication_model.dart' as model;
import 'package:shareplace_flutter/src/models/user_model.dart';
import 'package:shareplace_flutter/src/providers/publication_provider.dart';


class OtherProfilePage extends StatefulWidget {

  @override
  _OtherProfilePageState createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {

  final publicationsProvider = new PublicationProvider();

  User user;
  List<model.Publication> _publications = new List<model.Publication>();
  int _page = 1;
  bool _isLoading = false;

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener((){

      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchData();
      }

    });
  }

  @override
  Widget build(BuildContext context) {

    user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 241, 246, 1),
      appBar: AppBar(
        elevation: 12.0,
        backgroundColor: Color.fromRGBO(125, 201, 231, 1),
        title: Text('Perfil'),
        centerTitle: true,
        leading: FloatingActionButton(
          
          child: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
          backgroundColor: Colors.transparent,
          hoverColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          elevation: 0,
          focusElevation: 0,
          hoverElevation: 0,
          highlightElevation: 0,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
          children: <Widget>[
            _perfil(user, context),
          ],
        ),
    );
  }

  Widget _perfil(User user, BuildContext context) {

    return RefreshIndicator(
      onRefresh: obtenerPagina1,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _avatar(user.image),
              _nombre(user.name, user.lastName),
              SizedBox(height: 30.0),
              _email(user.email),
              SizedBox(height: 30.0),
              _telefono(user.phone),
              SizedBox(height: 30.0),
              // _nacimiento(snapshot),
              // SizedBox(height: 30.0),
              _descripcion(user.description),
              SizedBox(height: 30.0),
              Container(
                margin: EdgeInsets.only(left: 50.0),
                width: double.infinity,
                child:Text('Publicaciones', style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.55)))
              ),
              _publicaciones(user.id),
            ],
          ),
        ),
      ),
    );

  }

  Widget _avatar(String image) {

    return Container(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: CircleAvatar(
        backgroundImage: NetworkImage('http://10.0.2.2/shareplace-backend---facundo-tenuta/public/img/' + image),
        radius: 80.0,
      ),
    );
  }

  Widget _nombre(String name, String lastName) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 50.0),
          width: double.infinity,
          child:Text('Nombre', style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.55)))
        ),
        SizedBox(height: 10.0),
        Container(
          margin: EdgeInsets.only(left: 55.0, right: 55.0),
          width: double.infinity,
          child: Text(name + ' ' + lastName, style: TextStyle(fontSize: 20)),
        ),
      ],
    );
    
  }

  Widget _email(String email) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 50.0),
          width: double.infinity,
          child:Text('Correo electronico', style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.55)))
        ),
        SizedBox(height: 10.0),
        Container(
          margin: EdgeInsets.only(left: 55.0, right: 55.0),
          width: double.infinity,
          child: Text(email, style: TextStyle(fontSize: 20)),
        ),
      ],
    );
    
  }

  Widget _telefono(String phone) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 50.0),
          width: double.infinity,
          child:Text('Telefono', style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.55)))
        ),
        SizedBox(height: 10.0),
        Container(
          margin: EdgeInsets.only(left: 55.0, right: 55.0),
          width: double.infinity,
          child: Text(phone, style: TextStyle(fontSize: 20)),
        ),
      ],
    );
    
  }

  Widget _descripcion(String description) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 50.0),
          width: double.infinity,
          child:Text('Descripción', style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.55)))
        ),
        SizedBox(height: 10.0),
        Container(
          margin: EdgeInsets.only(left: 55.0, right: 55.0),
          width: double.infinity,
          child: description != null ? Text(description, style: TextStyle(fontSize: 20)) : Text(' ', style: TextStyle(fontSize: 20)),
        ),
      ],
    );

  }

  Widget _publicaciones(int user){

    Future<List<model.Publication>> resp = publicationsProvider.cargarMisPublications(user, _page);

    return FutureBuilder(
      future: resp,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if (snapshot.hasData) {
          if (snapshot.data.isNotEmpty) {
            for (var i = 0; i < snapshot.data.length; i++) {
              if (!_publications.contains(snapshot.data[i])) {
                _publications.add(snapshot.data[i]);
              } 
            }
            // if (snapshot.data.length == 10) {
            //   _page++;
            // }
          }

          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 30, right: 30, top: 10),
            // controller: _scrollController,
            itemCount: _publications.length,
            itemBuilder: (BuildContext context, int index){
              return FadeIn(
                child: _publication(context, _publications[index]),
                duration: Duration(seconds: 1),
              );
            },
          );
      }else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
      }
    );


  }

  Future<Null> obtenerPagina1() async {


      _publications.clear();
      _page = 1;
      _cargarMisPublicaciones();
      if (_publications.isEmpty) {
        
      }

  }

  void _cargarMisPublicaciones() async{

    final resp = await publicationsProvider.cargarMisPublications(user.id, _page);

    if (resp.isNotEmpty) {
      for (var i = 0; i < resp.length; i++) {
        if (!_publications.contains(resp[i])) {
          _publications.add(resp[i]);
        } 
      }
      if (resp.length == 10) {
        _page++;
      }
    }

    setState(() {
      
    });

  }

  Future fetchData() async{

    _isLoading = true;
    setState(() {
      
    });
    respuestaHTTP();

  }

  void respuestaHTTP(){
    _isLoading = false;
    
    _scrollController.animateTo(
      _scrollController.position.pixels + 100,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 250)
    );

    _cargarMisPublicaciones();
  }

  Widget _crearLoading() {

    if (_isLoading) {
      return  Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator()
            ],
          ),
          SizedBox(height: 15.0)
          
        ],
      );
      
      
    } else{
      return Container();
    }

  }

  Widget _listaVacia(){

    if (_publications.isEmpty) {
      return Center(child: Text('No posee publicaciones'));
    }else{
      return Container();
    }

  }

  Widget _publication(BuildContext context, model.Publication publi) {

    // final size = MediaQuery.of(context).size;

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: <BoxShadow> [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                )
              ]
            
            ),
        child: ClipRRect(
          
          borderRadius: BorderRadius.circular(15.0),
          child: Row(
            children: <Widget>[
              FadeInImage(
                  // image: NetworkImage(publi.principalImage),
                  image: NetworkImage('http://10.0.2.2/shareplace-backend---facundo-tenuta/public/img/${publi.principalImage}'),
                  placeholder: AssetImage('assets/24.gif'),
                  fadeInDuration: Duration(milliseconds: 150),
                  height: 200.0,
                  width: 200.0,
                  fit: BoxFit.cover,
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    width: 130,
                    child: Center(
                      child: Text(publi.title.toString())
                    )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        // List arg;
        // Map arg = {"publi": publi, "perfil": false};
        ArgumentosOtherProfile arg = ArgumentosOtherProfile(publi, false);
        Navigator.pushNamed(context, 'publicationDetail', arguments: arg);
      },
    );
  }
}