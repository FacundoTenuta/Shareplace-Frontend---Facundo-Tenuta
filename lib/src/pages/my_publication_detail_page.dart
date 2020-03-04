


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shareplace_flutter/src/models/publication_model.dart' as model;
import 'package:shareplace_flutter/src/providers/publication_provider.dart';
import 'package:shareplace_flutter/src/widgets/menu_widget.dart';
import 'package:shareplace_flutter/src/utils/utils.dart' as utils;

class MyPublicationDetailPage extends StatefulWidget{

  @override
  _MyPublicationDetailPageState createState() => _MyPublicationDetailPageState();
}

class _MyPublicationDetailPageState extends State<MyPublicationDetailPage> {

  int _current = 0;

  @override
  Widget build(BuildContext context) {

    // final model.Publication publi = ModalRoute.of(context).settings.arguments;

    final publicationProvider = Provider.of<PublicationProvider>(context);

    // publicationProvider.setPublicationReal(publi);

    model.Publication publi = publicationProvider.getPublicationReal;
    
    // provider.setConditions(publi.conditions);
    // provider.setDescription(publi.description);
    // provider.setImages(publi.images);
    // provider.setPrincipalImage(publi.principalImage);
    // provider.setTitle(publi.title);

    // final model.Publication publi = ModalRoute.of(context).settings.arguments;

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
      // body: _publicacion(context, publi),
      body: _publicacion(context),
            
      floatingActionButton: Container(
        margin: EdgeInsets.all(20.0),
        child: FloatingActionButton(
          heroTag: null,
          backgroundColor: Color.fromRGBO(0, 150, 136, 1),
          child: Icon(Icons.edit, size: 35,),
          onPressed: (){
            Navigator.pushNamed(context, 'editPublicationPage');
            final provider = Provider.of<PublicationProvider>(context, listen: false);
    
            provider.setArguments(publi.id, publi.title, publi.principalImage, publi.images, publi.description, publi.conditions);
          },
        ),
      ),

    );
  }
// , model.Publication publi
  Widget _publicacion(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          
          Consumer<PublicationProvider>(
            builder:(_, provider, __)=> Container(
              child: _carousel(provider.getPublicationReal),
            ),
          ),
          Consumer<PublicationProvider>(
            builder: (_, provider, __)=> Container(
              padding: EdgeInsets.all(20),
              child: Text(
                provider.getPublicationReal.title.toString(), 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
            ),
          ),
          Consumer<PublicationProvider>(
            builder:(_, provider, __)=> Text(provider.getPublicationReal.description.toString())
          ),
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.only(left: 45),
            alignment: Alignment.centerLeft,
            child: Text('Condiciones', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 0.55)))
          ),
          Consumer<PublicationProvider>(
            builder:(_, provider, __)=> _conditions(provider.getPublicationReal)
          ),
          SizedBox(height: 20.0),
          Consumer<PublicationProvider>(
            builder: (_, provider, __)=> _botonCambiarEstado(provider),
          ),
          SizedBox(height: 20.0),
          Consumer<PublicationProvider>(
            builder:(_, provider, __)=> _botonBorrar(provider)
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
    



  }

  Widget _conditions(model.Publication publi) {

    List<model.Condition> conditions = publi.conditions;

    return Container(
      margin: EdgeInsets.only(left: 75),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: conditions.length,
          itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.fiber_manual_record, size: 12, color: Color.fromRGBO(1, 1, 1, 0.55)),
                Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Text(conditions[index].name)
                ),
              ],
            );
         },
        ),
    );
  }

  Widget _carousel(model.Publication publi) {

    List<Widget> imagenes = _imagenes(publi);

    // final size = MediaQuery.of(context).size;

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
            Navigator.popAndPushNamed(context, 'myPublications');
          },
        )
      ]
    );

  }

  List<Widget> _imagenes(model.Publication publi) {

    String url = 'http://10.0.2.2/shareplace-backend---facundo-tenuta/public/img/';

    final List<Widget> lista = List();

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

  Widget _botonBorrar(PublicationProvider provider) {

    return ButtonTheme(
          minWidth: 130.0,
          height: 50.0,
          child: RaisedButton(
            padding: EdgeInsets.only(right: 15, left: 15),
            textColor: Colors.white,
            color: Color.fromRGBO(238, 1, 1, 1),
            child: Text('Borrar publicación', style: TextStyle(fontSize: 18),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onPressed: ()async {
              String respuesta = await provider.borrarPublicacion();
              // Navigator.popAndPushNamed(context, 'myPublications');
              Navigator.of(context).pushNamedAndRemoveUntil('myPublications', ModalRoute.withName('home'));
              if (respuesta == '200') {

                utils.mostrarAlerta(context, 'Tu publicación', 'Se eliminó el tu publicación correctamente.');

              }else{

                utils.mostrarAlerta(context, 'Ops! Algo salió mal', 'Hubo un problema al intentar eliminar tu publicación.');

              }    
            },
          ),
        );

  }

  Widget _botonCambiarEstado(PublicationProvider provider) {

    String texto;
    Color color;

    if (provider.getPublicationReal.state) {
      texto = 'Suspender';
      color = Color.fromRGBO(0, 102, 204, 1);
    }else{
      texto = 'Activar';
      color = Color.fromRGBO(102, 204, 0, 1);
    }

    return ButtonTheme(
          minWidth: 130.0,
          height: 50.0,
          child: RaisedButton(
            padding: EdgeInsets.only(right: 15, left: 15),
            textColor: Colors.white,
            color: color,
            child: Text(texto, style: TextStyle(fontSize: 18),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onPressed: ()async {
              String respuesta = await provider.cambiarEstadoPublicacion();
              if (respuesta == '200') {

                utils.mostrarAlerta(context, 'Tu publicación', 'Se cambió el estado de tu publicación correctamente.');

              }else{

                utils.mostrarAlerta(context, 'Ops! Algo salió mal', 'Hubo un problema al cambiar el estado de tu publicación');

              }    
            },
          ),
        );

  }
}

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

