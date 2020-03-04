
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shareplace_flutter/src/providers/publication_provider.dart';
import 'package:shareplace_flutter/src/utils/utils.dart' as utils;

class LogoutOverlay extends StatefulWidget {
      @override
      State<StatefulWidget> createState() => LogoutOverlayState();
    }

    class LogoutOverlayState extends State<LogoutOverlay>
        with SingleTickerProviderStateMixin {

          final formKey = GlobalKey<FormState>();

          String motivo;

          DateTime desde = DateTime.now();
          DateTime hasta = DateTime.now();

      AnimationController controller;
      Animation<double> scaleAnimation;

      @override
      void initState() {
        super.initState();

        controller =
            AnimationController(vsync: this, duration: Duration(milliseconds: 450));
        scaleAnimation =
            CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

        controller.addListener(() {
          setState(() {});
        });

        controller.forward();
      }

      @override
      Widget build(BuildContext context) {

        final publicationProvider = Provider.of<PublicationProvider>(context);

        return Center(
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Container(
                // margin: EdgeInsets.(20.0),
                  padding: EdgeInsets.all(15.0),
                  height: 490.0,
                  width: 325,
                  decoration: ShapeDecoration(
                      color: Color.fromRGBO(229, 241, 246, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                  child: Form(
                    key: formKey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Container(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Text('Solicitud', style: TextStyle(fontSize: 20),),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                            // child: Padding(
                          // padding: const EdgeInsets.only(
                              // top: 30.0, left: 20.0, right: 20.0),
                          child: Text(
                            "¿Por qué lo solicitas?",
                            style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.55), fontSize: 16.0, fontStyle: FontStyle.italic),
                          ),
                        ),

                        Flexible(
                          child: Container(
                            width: 280,
                            height: 200,
                            padding: EdgeInsets.only(left: 15.0, right: 15.0),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              expands: true,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: 'Ingrese el motivo de la solicitud aquí',
                                contentPadding: EdgeInsets.only(top: 0, left: 0, bottom: 0),
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (input) => motivo = input,
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text('Fechas estimadas', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Color.fromRGBO(149, 152, 154, 0.85)),),
                        ),


                        _fechaDesde(context),



                        _fechaHasta(context),
                        

                        Container(
                          margin: EdgeInsets.only(top: 10),
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ButtonTheme(
                                  height: 35.0,
                                  minWidth: 110.0,
                                  child: RaisedButton(
                                    padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                                    color: Color.fromRGBO(26, 176, 181, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0)),
                                    // splashColor: Colors.white.withAlpha(40),
                                    child: Text(
                                      'Solicitar prestamo',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.0),
                                    ),
                                    onPressed: () async{
                                      formKey.currentState.save();

                                        String respuesta = await publicationProvider.solicitarPublicacion(motivo, desde, hasta);
                                        
                                        // Route route = MaterialPageRoute(
                                        //     builder: (context) => LoginScreen());
                                        Navigator.pop(context);
                                        if (respuesta == '201') {

                                          utils.mostrarAlerta(context, 'Solicitud', 'La solicitud se emitió correctamente.');

                                        }else{

                                          utils.mostrarAlerta(context, 'Ops! Algo salió mal', 'Hubo un problema al intentar emitir la solicitud.');

                                        }  
                                      setState(() {

                                         
                                      });
                                    },
                                  )),
                            ),
                          ],
                        ))
                      ],
                    ),
                  )),
            ),
          ),
        );
      }

  Widget _fechaHasta(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 15),
          child: Text('Hasta:', style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Color.fromRGBO(149, 152, 154, 1)),)
        ),
        Container(
          width: 80,
          height: 20,
          padding: EdgeInsets.only(top: 2),
          child: Text(hasta.day.toString() + '/' + hasta.month.toString() + '/' + hasta.year.toString()),
        ),
        Container(
          child: IconButton(
            icon: Icon(Icons.calendar_today, color: Color.fromRGBO(0, 0, 238, 1),),
            onPressed: (){
              showDatePicker(
                context: context,
                initialDate: hasta,
                firstDate: DateTime.now().subtract(Duration(days: 1)),
                lastDate: DateTime(2030),
              ).then((date){
                setState(() {
                  hasta = date;
                });
              });
            }
          ),
        )
      ],
    );
  }

  Widget _fechaDesde(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 15),
          child: Text('Desde:', style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Color.fromRGBO(149, 152, 154, 1)),)
        ),
        Container(
          width: 80,
          height: 20,
          padding: EdgeInsets.only(top: 2),
          child: Text(desde.day.toString() + '/' + desde.month.toString() + '/' + desde.year.toString()),
        ),
        Container(
          child: IconButton(
            icon: Icon(Icons.calendar_today, color: Color.fromRGBO(0, 0, 238, 1),),
            onPressed: (){
              showDatePicker(
                context: context,
                initialDate: desde,
                firstDate: DateTime.now().subtract(Duration(days: 1)),
                lastDate: DateTime(2030),
              ).then((date){
                setState(() {
                  desde = date;
                });
              });
            }
          ),
        )
      ],
    );
  }
}
