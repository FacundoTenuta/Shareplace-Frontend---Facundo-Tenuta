import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/models/argumentos_other_profile_model.dart';
import 'package:shareplace_flutter/src/models/publication_model.dart' as model;
import 'package:shareplace_flutter/src/providers/publication_provider.dart';
import 'package:shareplace_flutter/src/search/search_delegate.dart';
import 'package:shareplace_flutter/src/widgets/menu_widget.dart';

class HomePage extends StatefulWidget {

  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final publicationsProvider = new PublicationProvider();

  ScrollController _scrollController = new ScrollController();

  List<model.Publication> _publications = new List<model.Publication>();
  int _page = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    
    _cargarPublicaciones();

    _scrollController.addListener((){

      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchData();
      }

    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 241, 246, 1),
      drawer: MenuWidget(),
      appBar: AppBar(
        elevation: 12.0,
        backgroundColor: Color.fromRGBO(125, 201, 231, 1),
        title: Text('Inicio'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(
                context: context,
                delegate: DataSearch(),
                // query: 'asdads'
              );
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          _crearLista(),
          _crearLoading(),
        ],
      ) 
      
      
    );
  }

  Widget _crearLista(){

    return RefreshIndicator(
      onRefresh: obtenerPagina1,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
        controller: _scrollController,
        itemCount: _publications.length,
        itemBuilder: (BuildContext context, int index){
          return FadeIn(
            child: _publication(context, _publications[index]),
            duration: Duration(seconds: 1),
          );
        },
      ),
    );

  }

  Future<Null> obtenerPagina1() async {


      _publications.clear();
      _page = 1;
      _cargarPublicaciones();

  }


  void _cargarPublicaciones() async{

    final resp = await publicationsProvider.cargarPublications(_page);

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

    _cargarPublicaciones();
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
                  spreadRadius: 2.0,
                )
              ]
            
            ),
        child: ClipRRect(
          
          borderRadius: BorderRadius.circular(15.0),
          child: Row(
            children: <Widget>[
              FadeInImage(
                  image: NetworkImage('http://10.0.2.2/shareplace-backend---facundo-tenuta/public/img/${publi.principalImage}'),
                  // image: AssetImage('assets/camara.jpg'),
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
        ArgumentosOtherProfile arg = ArgumentosOtherProfile(publi, true);
        Navigator.pushNamed(context, 'publicationDetail', arguments: arg);
      },
    );
  }
}