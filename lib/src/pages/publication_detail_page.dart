


import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/models/publication_model.dart' as model;
import 'package:shareplace_flutter/src/widgets/menu_widget.dart';

class PublicationDetailPage extends StatefulWidget{

  @override
  _PublicationDetailPageState createState() => _PublicationDetailPageState();
}

class _PublicationDetailPageState extends State<PublicationDetailPage> {

  int _current = 0;

  @override
  Widget build(BuildContext context) {

    final model.Publication publi = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MenuWidget(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(125, 201, 231, 1),
        title: Text('Publicación'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body: _publicacion(context, publi),
    );
  }

  Widget _publicacion(BuildContext context, model.Publication publi) {

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          
          Container(
          child: _carousel(publi),
          ),
          Text(publi.title.toString()),
          Text(publi.description.toString()),
          Text('Condiciones'),
          Text(publi.conditions.toString()),
          Text('Usuario'),
          Row(
            children: <Widget>[
              Icon(Icons.person),
              Text(publi.userId.toString()),
            ],
          ),
          RaisedButton(
            child: Container(
              child: Text('Solicitar Préstamo'),
            ),
            onPressed: (){},
          ),
          RaisedButton(
            child: Container(
              child: Text('Denunciar'),
            ),
            onPressed: (){},
          )
        ],
      ),
    );
    



  }

  Widget _carousel(model.Publication publi) {

    List<Widget> imagenes = _imagenes(publi);

    final size = MediaQuery.of(context).size;

    return Stack(
      children: [

        
        
        CarouselSlider(
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          height: 400,
          items: imagenes,
          autoPlay: false,
          aspectRatio: 2.0,
          onPageChanged: (index) {
            setState(() {
              print(_current);
              _current = index;
            });
          },
        ),
        Positioned(
          
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(imagenes, (index, url) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4)
                ),
              );
            }),
          )
        ),
        FloatingActionButton(
          
          child: Icon(Icons.arrow_back, color: Colors.black45, size: 40,),
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
        )
      ]
    );

  }

  List<Widget> _imagenes(model.Publication publi) {

    String url = 'http://10.0.2.2/shareplace-backend---facundo-tenuta/public/img/';

    final List<Widget> lista = List();
    // print(publi.images[i].path.toString());

    lista.add(FadeInImage(
      fit: BoxFit.contain,
      image: NetworkImage(url + publi.principalImage.toString()),
      placeholder: AssetImage('assets/24.gif'),
    ));

    for (var i = 0; i < publi.images.length; i++) {
      lista.add(FadeInImage(
        image: NetworkImage(url + publi.images[i].path.toString()),
        placeholder: AssetImage('assets/24.gif'),
      ));
    }
    
    return lista;


  }
}

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

