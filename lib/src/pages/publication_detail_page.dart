


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shareplace_flutter/src/models/argumentos_other_profile_model.dart';
import 'package:shareplace_flutter/src/models/publication_model.dart' as model;
import 'package:shareplace_flutter/src/models/user_model.dart';
import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:shareplace_flutter/src/providers/publication_provider.dart';
import 'package:shareplace_flutter/src/providers/user_provider.dart';
import 'package:shareplace_flutter/src/widgets/menu_widget.dart';
import 'package:shareplace_flutter/src/widgets/request_modal_widget.dart';

class PublicationDetailPage extends StatefulWidget{

  @override
  _PublicationDetailPageState createState() => _PublicationDetailPageState();
}

class _PublicationDetailPageState extends State<PublicationDetailPage> {

  final prefs = PreferenciasUsuario();

  int _current = 0;

  bool usuario = true;

  @override
  Widget build(BuildContext context) {

    ArgumentosOtherProfile arg = ModalRoute.of(context).settings.arguments;

    

    final model.Publication publi = arg.publi;

    usuario = arg.perfilHabilitado;

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
      body: _publicacion(context, publi),
    );
  }

  Widget _publicacion(BuildContext context, model.Publication publi) {

    final publicationProvider = Provider.of<PublicationProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          
          Container(
          child: _carousel(publi),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              publi.title.toString(), 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
          ),
          Text(publi.description.toString()),
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.only(left: 45),
            alignment: Alignment.centerLeft,
            child: Text('Condiciones', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 0.55)))
          ),
          _conditions(publi),
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 0),
            margin: EdgeInsets.only(left: 45),
            alignment: Alignment.centerLeft,
            child: Text('Usuario', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Color.fromRGBO(0, 0, 0, 0.55)))
          ),
          _usuario(publi),
          SizedBox(height: 20.0),
          _botones(publicationProvider, publi, context),
          
          SizedBox(height: 20.0),
        ],
      ),
    );
    



  }

  Widget _botones(PublicationProvider publicationProvider, model.Publication publi, BuildContext context) {
    if (prefs.user != publi.userId) {
      return Column(
        children: <Widget>[
          ButtonTheme(
            minWidth: 130.0,
            height: 50.0,
            child: RaisedButton(
              
              padding: EdgeInsets.only(right: 20, left: 20),
              textColor: Colors.white,
              color: Color.fromRGBO(26, 176, 181, 1),
              child: Container(
                child: Text('Solicitar Préstamo', style: TextStyle(fontSize: 18))
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              onPressed: (){
                  publicationProvider.setPublication(publi);
                  showDialog(
                    context: context,
                    builder: (_) => LogoutOverlay(),
                  );
              },
            ),
          ),
          SizedBox(height: 20.0),
          ButtonTheme(
            minWidth: 130.0,
            height: 50.0,
            child: RaisedButton(
              padding: EdgeInsets.only(right: 20, left: 20),
              textColor: Colors.white,
              color: Color.fromRGBO(238, 1, 1, 1),
              child: Container(
                child: Text('Denunciar', style: TextStyle(fontSize: 18)),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              onPressed: (){},
            ),
          ),
        ],
      );
    }else{
      return Container();
    }
  }

  Widget _usuario(model.Publication publi) {

    if (usuario) {
      
      Future<User> user = UserProvider().obtenerUsuario(publi.userId);

      return FutureBuilder(
        future: user,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return RaisedButton(
              child: Container(              
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.person),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Text(snapshot.data.name + ' ' + snapshot.data.lastName, style: TextStyle(color: Color.fromRGBO(0, 0, 238, 1)),)
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              onPressed: (){
                Navigator.pushNamed(context, 'otherProfile', arguments: snapshot.data);
              },
            );
          }else{
            return Text('Cargando...');
          }
        }
      );
    }else{
      return Container();
    }
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
            Navigator.pop(context);
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

  // List<Widget> _conditionsList(model.Publication publi) {}
}

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

