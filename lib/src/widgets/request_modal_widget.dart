
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shareplace_flutter/src/providers/publication_provider.dart';

class LogoutOverlay extends StatefulWidget {
      @override
      State<StatefulWidget> createState() => LogoutOverlayState();
    }

    class LogoutOverlayState extends State<LogoutOverlay>
        with SingleTickerProviderStateMixin {

          final formKey = GlobalKey<FormState>();

          String motivo;

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
                  height: 450.0,
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
                                margin: EdgeInsets.only(top: 10, bottom: 20),
                                child: Text('Solicitud', style: TextStyle(fontSize: 20),),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 10),
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
                            height: 240,
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
                                    onPressed: () {
                                      setState(() {

                                        formKey.currentState.save();

                                        publicationProvider.solicitarPublicacion(motivo);
                                        
                                        // Route route = MaterialPageRoute(
                                        //     builder: (context) => LoginScreen());
                                        Navigator.pop(context);
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
    }
