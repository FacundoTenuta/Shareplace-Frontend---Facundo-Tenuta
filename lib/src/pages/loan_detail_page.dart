
import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/models/argumentos_other_profile_model.dart';
import 'package:shareplace_flutter/src/models/publication_model.dart';
import 'package:shareplace_flutter/src/models/requestion_model.dart';
import 'package:shareplace_flutter/src/models/user_model.dart';
import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:shareplace_flutter/src/providers/publication_provider.dart';
import 'package:shareplace_flutter/src/providers/requestion_provider.dart';
import 'package:shareplace_flutter/src/providers/user_provider.dart';
import 'package:shareplace_flutter/src/utils/utils.dart' as utils;

class LoanDetailPage extends StatelessWidget {
  const LoanDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Requestion prestamo = ModalRoute.of(context).settings.arguments;

    Widget titulo;

    if (!prestamo.active) {
      titulo = Text('Prestamo finalizado');
    }else{
      titulo = Text('Prestamo');
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 241, 246, 1),
      appBar: AppBar(
        elevation: 12.0,
        backgroundColor: Color.fromRGBO(125, 201, 231, 1),
        title: titulo,
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
      body: _prestamo(prestamo),
    );
  }

  Widget _prestamo(Requestion prestamo) {

    Future<Publication> publi = PublicationProvider().obtenerPublicacion(prestamo.publicationId);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 30),
            child: Text('Prestamo de: ' + prestamo.title, style: TextStyle(fontSize: 23, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Color.fromRGBO(149, 152, 154, 0.85)))
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 20),
                child: _publicationImage(prestamo, publi)
              ),
              _usuarios(prestamo, publi)
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 30),
            child: _fechas(prestamo)
          ),
          _botones(prestamo, publi),
          SizedBox(height: 20),
        ],
      ),
    );

  }

  Widget _usuarios(Requestion prestamo, Future<Publication> publi) {

    final prefs = PreferenciasUsuario();

    

    return FutureBuilder(
      future: publi,
      builder: (BuildContext context, AsyncSnapshot<Publication> snapshot) {
        
        if (snapshot.hasData) {


          if (prestamo.requesterId == prefs.user) {

            Future<User> user = UserProvider().obtenerUsuario(snapshot.data.userId);

            return FutureBuilder(
              future: user,
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {

                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      Text('Prestador', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Color.fromRGBO(149, 152, 154, 0.85))),
                      RaisedButton(
                        child: Container(              
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.person),
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: 130,
                                ),
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
                      ),
                    ],
                  );
                }else{
                  return Container(
                    height: 140.0,
                    width: 140.0,
                    child: Center(
                      child: CircularProgressIndicator()
                    )
                  );
                }
              },
            );

          }else{

            Future<User> user = UserProvider().obtenerUsuario(prestamo.requesterId);

            return FutureBuilder(
              future: user,
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {

                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      Text('Prestatario', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Color.fromRGBO(149, 152, 154, 0.85))),
                      RaisedButton(
                        child: Container(              
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.person),
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: 130,
                                ),
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
                      ),
                    ],
                  );
                }else{
                  return Container(
                    height: 140.0,
                    width: 140.0,
                    child: Center(
                      child: CircularProgressIndicator()
                    )
                  );
                }
              },
            );
          }
        }else{
          return Container(
            height: 140.0,
            width: 140.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
        
      },
    );
    
  }

  Widget _publicationImage(Requestion prestamo, Future<Publication> publi) {

    

    return FutureBuilder(
      future: publi,
      builder: (BuildContext context, AsyncSnapshot<Publication> snapshot) {

        if (snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage(
              image: NetworkImage('http://10.0.2.2/shareplace-backend---facundo-tenuta/public/img/${snapshot.data.principalImage}'),
              placeholder: AssetImage('assets/24.gif'),
              fadeInDuration: Duration(milliseconds: 150),
              height: 140.0,
              width: 140.0,
              fit: BoxFit.cover,
            ),
          );
        }else{
          return Container(
            height: 140.0,
            width: 140.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }

        
      },
    );

  }

  Widget _botones(Requestion prestamo, Future<Publication> publi) {

    Widget botonFinalizar;

    

    return FutureBuilder(
      future: publi,
      builder: (BuildContext context, AsyncSnapshot<Publication> snapshot) {

        if (snapshot.hasData) {
          if (prestamo.active) {
            botonFinalizar =  ButtonTheme(
              buttonColor: Color.fromRGBO(26, 176, 181, 1),
              minWidth: 130.0,
              height: 50.0,
              child: RaisedButton(
                padding: EdgeInsets.only(right: 15, left: 15),
                textColor: Colors.white,
                // color: color,
                child: Text('Finalizar prestamo', style: TextStyle(fontSize: 18),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () async{
                  String respuesta = await RequestionProvider().finalizarPrestamo(prestamo.id);
                  Navigator.of(context).pushNamedAndRemoveUntil('loans', ModalRoute.withName('home'));
                  if (respuesta == '200') {

                    utils.mostrarAlerta(context, 'Tu prestamo', 'Se finalizó tu prestamo correctamente.');

                  }else{

                    utils.mostrarAlerta(context, 'Ops! Algo salió mal', 'Hubo un problema al intentar finalizar tu prestamo.');

                  }   
                },
              ),
            );
          }else{
            botonFinalizar = Container();
          }

          return Column(
            children: <Widget>[
              ButtonTheme(
                buttonColor: Color.fromRGBO(10, 116, 209, 1),
                minWidth: 130.0,
                height: 50.0,
                child: RaisedButton(
                  padding: EdgeInsets.only(right: 15, left: 15),
                  textColor: Colors.white,
                  // color: color,
                  child: Text('Ver publicación', style: TextStyle(fontSize: 18),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  onPressed: (){
                    ArgumentosOtherProfile arg = ArgumentosOtherProfile(snapshot.data, true);
                    Navigator.pushNamed(context, 'publicationDetail', arguments: arg);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: botonFinalizar
              ),
            ],
          );
        }else{
          return Container(
            height: 40.0,
            width: 40.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }

        
      },
    );
    

  }

  Widget _fechas(Requestion prestamo) {

    return Column(
      children: <Widget>[
        Text('Fecha de inicio', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Color.fromRGBO(149, 152, 154, 0.85))),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(prestamo.startDate.day.toString() + '/' + prestamo.startDate.month.toString() + '/' + prestamo.startDate.year.toString(), style: TextStyle(fontSize: 18),)
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: _fechaFinalizacion(prestamo)
        ),
      ],
    );

  }

  Widget _fechaFinalizacion(Requestion prestamo) {

    if (!prestamo.active) {
      return Column(
        children: <Widget>[
          Text('Fecha de finalización', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Color.fromRGBO(149, 152, 154, 0.85))),
          Text(prestamo.endDate.day.toString() + '/' + prestamo.endDate.month.toString() + '/' + prestamo.endDate.year.toString(), style: TextStyle(fontSize: 18),),
        ],
      );
    }else{
      return Column(
        children: <Widget>[
          Text('Fecha de finalización estimada', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Color.fromRGBO(149, 152, 154, 0.85))),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(prestamo.untilDate.day.toString() + '/' + prestamo.untilDate.month.toString() + '/' + prestamo.untilDate.year.toString(), style: TextStyle(fontSize: 18),)
          ),
        ],
      );
    }

  }
}