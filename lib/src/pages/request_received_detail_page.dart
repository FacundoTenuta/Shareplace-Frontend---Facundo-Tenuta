

// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/models/argumentos_other_profile_model.dart';
import 'package:shareplace_flutter/src/models/publication_model.dart';
import 'package:shareplace_flutter/src/models/requestion_model.dart';
import 'package:shareplace_flutter/src/models/user_model.dart';
import 'package:shareplace_flutter/src/providers/publication_provider.dart';
import 'package:shareplace_flutter/src/providers/requestion_provider.dart';
import 'package:shareplace_flutter/src/providers/user_provider.dart';


class RequestReceivedDetailPage extends StatelessWidget {
  const RequestReceivedDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Requestion solicitud = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 241, 246, 1),
      appBar: AppBar(
        elevation: 12.0,
        backgroundColor: Color.fromRGBO(125, 201, 231, 1),
        title: Text('Solicitud recibida'),
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

      body: _solicitud(solicitud, context),

    );
  }

  Widget _solicitud(Requestion solicitud, BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top:40),
            child: Text('Publicación', style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Color.fromRGBO(149, 152, 154, 0.85)),),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
            child: _publicacion(solicitud.publicationId)
          ),
          Container(
            child: Text('Usuario', style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Color.fromRGBO(149, 152, 154, 0.85)),),
          ),
          Container(
            child: _usuario(solicitud.requesterId),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text('Fechas estimadas', style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Color.fromRGBO(149, 152, 154, 0.85)),),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: _fechaDesde(solicitud.startDate)
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: _fechaHasta(solicitud.untilDate)
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text('Motivo', style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Color.fromRGBO(149, 152, 154, 0.85)),),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: _motivo(solicitud.reason)
          ),
          Container(
            margin: EdgeInsets.only(top: 45, bottom: 30),
            child: _botones(context, solicitud.id)
          ),
        ],
      ),
    );

  }

  Widget _fechaHasta(DateTime untilDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 25),
          child: Text('Hasta:', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Color.fromRGBO(149, 152, 154, 1)),)
        ),
        Container(
          margin: EdgeInsets.only(right: 5),
          child: Text(untilDate.day.toString())
        ),
        Text('/'),
        Container(
          margin: EdgeInsets.only(right: 5, left: 5),
          child: Text(untilDate.month.toString())
        ),
        Text('/'),
        Container(
          margin: EdgeInsets.only(left: 5),
          child: Text(untilDate.year.toString())
        ),
      ],
    );
  }

  Widget _fechaDesde(DateTime startDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 25),
          child: Text('Desde:', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Color.fromRGBO(149, 152, 154, 1)),)
        ),
        Container(
          margin: EdgeInsets.only(right: 5),
          child: Text(startDate.day.toString())
        ),
        Text('/'),
        Container(
          margin: EdgeInsets.only(right: 5, left: 5),
          child: Text(startDate.month.toString())
        ),
        Text('/'),
        Container(
          margin: EdgeInsets.only(left: 5),
          child: Text(startDate.year.toString())
        ),
      ],
    );
  }

  Widget _publicacion(int publicationId) {

    final publication = PublicationProvider().obtenerPublicacion(publicationId);

    return FutureBuilder(
      future: publication,
      builder: (BuildContext context, AsyncSnapshot<Publication> snapshot) {
        if (snapshot.hasData) {
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
                        image: NetworkImage('http://10.0.2.2/shareplace-backend---facundo-tenuta/public/img/${snapshot.data.principalImage}'),
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
                            child: Text(snapshot.data.title.toString())
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            onTap: (){
              ArgumentosOtherProfile arg = ArgumentosOtherProfile(snapshot.data, false);
              Navigator.pushNamed(context, 'publicationDetail', arguments: arg);
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
      },
    );

  }

  Widget _motivo(String reason) {
    return Container(
      margin: EdgeInsets.only(left: 55.0, right: 55.0),
      width: double.infinity,
      child: reason != null ? Text(reason, style: TextStyle(fontSize: 20)) : Text(' ', style: TextStyle(fontSize: 20)),
    );
  }

  Widget _usuario(int userId) {

      Future<User> user = UserProvider().obtenerUsuario(userId);

      return FutureBuilder(
        future: user,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return RaisedButton(
              color: Colors.white,
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
  }

  Widget _botones(context, int id) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ButtonTheme(
          minWidth: 130.0,
          height: 50.0,
          child: RaisedButton(
            padding: EdgeInsets.only(right: 10, left: 10),
            textColor: Colors.white,
            color: Color.fromRGBO(238, 1, 1, 1),
            child: Text('Rechazar', style: TextStyle(fontSize: 18),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onPressed: () async {
              await RequestionProvider().eliminarSolicitud(id);
              Navigator.popAndPushNamed(context, 'requests');
            },
          ),
        ),
        ButtonTheme(
          minWidth: 130.0,
          height: 50.0,
          child: RaisedButton(
            padding: EdgeInsets.only(right: 10, left: 10),
            textColor: Colors.white,
            color: Color.fromRGBO(10, 116, 209, 1),
            child: Text('Aceptar', style: TextStyle(fontSize: 18),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onPressed: (){
              // formKey.currentState.save();
              // publicationProvider.editarPublicacion(_imagePrincipal);

              Navigator.pop(context);

            },
          ),
        ),
      ],
    );
  }
}