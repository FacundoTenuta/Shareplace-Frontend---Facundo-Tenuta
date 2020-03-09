
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:shareplace_flutter/src/providers/publication_provider.dart';
import 'package:shareplace_flutter/src/utils/utils.dart' as utils;



class NewPublicationPage extends StatefulWidget{

  @override
  _NewPublicationPageState createState() => _NewPublicationPageState();
}

class _NewPublicationPageState extends State<NewPublicationPage> {
  final formKey = GlobalKey<FormState>();

  final prefs = PreferenciasUsuario();

  String _title, _description;

  File _principalImage;

  List<File> _extraImages = List();

  List<String> _conditions = List();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 241, 246, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(125, 201, 231, 1),
        title: Text('Nueva publicación'),
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

      body: _formulario(context),

    );
  }

  Widget _formulario(BuildContext context) {

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            _titulo(),
            SizedBox(height: 30),
            _descripcion(),
            SizedBox(height: 30),
            _condiciones(),
            SizedBox(height: 30),
            _imagenes(),
            SizedBox(height: 30),
            _boton(context),
            SizedBox(height: 30),
          ],
        ),
      ),
    );

  }

  Widget _titulo() {

    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 35, top: 5),
              child: Text('Titulo')
            ),
            Flexible(
              child: Container(
                width: 260,
                padding: EdgeInsets.only(left: 20.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (input) => _title = input,
                    decoration: InputDecoration(
                      hintText: 'Ingrese un titulo',
                    ),
                  ),
                ),
            ),
          ],
        );
  }

  Widget _descripcion() {

    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 35, top: 20),
              child: Text('Descripción')
            ),
            Flexible(
              child: Container(
                width: 280,
                height: 140,
                padding: EdgeInsets.only(left: 20.0, right: 30),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: '       Ingrese una descripción',
                    contentPadding: EdgeInsets.only(top: 0, left: 0, bottom: 0),
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (input) => _description = input,
                ),
              ),
            ),
          ],
        );

  }

  Widget _condiciones() {

    TextEditingController controller = TextEditingController(text: '');

    String aux;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 0, top: 15,),
              child: Text('Condiciones')
            ),
            Flexible(
              child: Container(
                width: 220,
                padding: EdgeInsets.only(left: 20.0,),
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Ingrese una condicion',
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (input) => aux = input,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: FlatButton(
                child: Icon(Icons.add),
                onPressed: (){

                  if (aux != null) {
                    controller.clear();

                    this._conditions.add(aux);
                  }

                  setState(() {
                    
                  });

                }
              ),
            ),
          ],
        ),

        Container(
          margin: EdgeInsets.only(top: 10),
          child: _condicionesLista()
        ),

      ],
    );

    
  }

  Widget _condicionesLista() {

        if (_conditions.isNotEmpty) {

          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _conditions.length,
            itemBuilder: (BuildContext context, int index) {

              int indice = index;

              return Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 250,
                      child: Text(_conditions[index])
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: SizedBox(
                        width: 22.0,
                        height: 22.0,
                        child: FloatingActionButton(
                          heroTag: index,
                          backgroundColor: Color.fromRGBO(206, 80, 80, 1),
                          child: Icon(Icons.clear, size: 20.0,),
                          onPressed: () {
                            
                            String aux = _conditions[indice];

                            _conditions.remove(aux);

                            setState(() {
                              
                            });

                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }else{
          return Container();
        }
      
  }

  Widget _imagenes() {

    Color color1 = Color.fromRGBO(0, 150, 136, 1);
    Color color2 = Color.fromRGBO(142, 142, 142, 1);

    File extra;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 60),
              child: Text('Imagenes')
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20,),
                child: Text('Principal')
              ),
              Container(
                margin: EdgeInsets.only(top:10, left: 40),
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: _principalImage == null ? color1 : color2 ,
                    child: Icon(Icons.cloud_upload, size: 25.0,),
                    onPressed: () async {
                      if (_principalImage == null) {
                        _principalImage = await ImagePicker.pickImage(source: ImageSource.gallery);

                        setState(() {
                          
                        });
                      }
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:10, left: 10),
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: _principalImage == null ? color1 : color2 ,
                    child: Icon(Icons.camera_alt, size: 25.0,),
                    onPressed: () async {
                      if (_principalImage == null) {
                        _principalImage = await ImagePicker.pickImage(source: ImageSource.camera);

                        setState(() {
                          
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        _imagenPrincipal(),
            
        Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text('Otras')
              ),
              Container(
                margin: EdgeInsets.only(top:10, left: 50),
                padding: EdgeInsets.only(),
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Color.fromRGBO(0, 150, 136, 1),
                    child: Icon(Icons.cloud_upload, size: 25.0,),
                    onPressed: () async{
                      extra = await ImagePicker.pickImage(source: ImageSource.gallery);
                      if (await extra.exists()) {
                        _extraImages.add(extra);
                      }
                      setState(() {
                          
                      });
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:10, left: 10),
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Color.fromRGBO(0, 150, 136, 1),
                    child: Icon(Icons.camera_alt, size: 25.0,),
                    onPressed: () async {
                      if (_principalImage == null) {
                        extra = await ImagePicker.pickImage(source: ImageSource.camera);
                        if (await extra.exists()) {
                          _extraImages.add(extra);
                        }
                        setState(() {
                          
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 10, bottom: 15),
          child: _listaImagenes(),
        ),
        
      ],
    );

  }

  Widget _listaImagenes() {

        if (_extraImages.isNotEmpty) {

          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _extraImages.length,
            itemBuilder: (BuildContext context, int index) {

              int indice = index;
              
              return Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 130,
                      child: Image(image: FileImage(_extraImages[index]))
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: FloatingActionButton(
                          heroTag: null,
                          backgroundColor: Color.fromRGBO(206, 80, 80, 1),
                          child: Icon(Icons.remove, size: 24.0,),
                          onPressed: () {
                            int aux = indice;
                            _extraImages.removeAt(aux);
                            setState(() {
                              
                            });                            
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          );
        }else{
          return Container();
        }
  }

  Widget _boton(BuildContext context) {

    
    
    return ButtonTheme(
      minWidth: 130.0,
      height: 50.0,
      child: RaisedButton(
        padding: EdgeInsets.only(right: 10, left: 10),
        textColor: Colors.white,
        color: Color.fromRGBO(10, 116, 209, 1),
        child: Text('Crear', style: TextStyle(fontSize: 18),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        onPressed: () async {
          formKey.currentState.save();
          String respuesta = await PublicationProvider().crearPublicacion(this._title, this._description, this._conditions, this._principalImage, this._extraImages, prefs.user);

          Navigator.of(context).pushNamedAndRemoveUntil('myPublications', ModalRoute.withName('home'));

          if (respuesta == '201') {

            utils.mostrarAlerta(context, 'Nueva publicación', 'Tu nueva publicación se creó correctamente.');

          }else{

            utils.mostrarAlerta(context, 'Ops! Algo salió mal', 'Hubo un problema al crear la publicación.');

          }          

        },
      ),
    );

  }

  _imagenPrincipal() {
    if (_principalImage != null) {
      
    
      return Container(
        margin: EdgeInsets.only(top: 10, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150,
              child: Image(image: FileImage(_principalImage))
            ),
            Container(
              margin: EdgeInsets.only(left: 15),
              child: SizedBox(
                width: 24.0,
                height: 24.0,
                child: FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Color.fromRGBO(206, 80, 80, 1),
                  child: Icon(Icons.remove, size: 24.0,),
                  onPressed: () {
                    _principalImage = null;
                    setState(() {
                      
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }else{
      return Container();
    } 

  }
}