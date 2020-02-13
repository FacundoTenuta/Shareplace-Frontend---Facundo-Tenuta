import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shareplace_flutter/src/models/publication_model.dart' as model;
import 'package:shareplace_flutter/src/providers/publication_provider.dart';


class EditPublicationPage extends StatelessWidget {
  // const EditPublicationPage({Key key}) : super(key: key);

  // @override
  // _EditPublicationPageState createState() => _EditPublicationPageState();
// }

// class _EditPublicationPageState extends State<EditPublicationPage> {
  final formKey = GlobalKey<FormState>();

  // List<model.Condition> _conditions = new List<model.Condition>();

  // String _title, _description, _principalImage;

  // List<model.Image> _images;

  // List<model.Condition> _conditions;

  File _imagePrincipal, _imageExtra;


  @override
  Widget build(BuildContext context) {


    final publicationProvider = Provider.of<PublicationProvider>(context, listen: false);

    // final model.Publication publi = publicationProvider.getPublication;

    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 241, 246, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(125, 201, 231, 1),
        title: Text('Publicación'),
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

      body: _formulario(context, publicationProvider),

    );
  }

  Widget _formulario(BuildContext context, PublicationProvider publicationProvider) {

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            _titulo(publicationProvider),
            SizedBox(height: 30),
              _descripcion(publicationProvider),
            SizedBox(height: 30),
              _condiciones(publicationProvider),
            SizedBox(height: 30),
              _imagenes(publicationProvider),
            SizedBox(height: 30),
            _botones(context, publicationProvider),
            SizedBox(height: 30),
          ],
        ),
      ),
    );

  }

  Widget _titulo(PublicationProvider publicationProvider) {

    // TextEditingController controller = TextEditingController(text: title);

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
                // child: Consumer<PublicationProvider>(
                  child: TextFormField(
                    controller: TextEditingController(text: publicationProvider.getTitle),
                    keyboardType: TextInputType.text,
                    onSaved: (input) => publicationProvider.setTitle(input),
                  ),
                ),
              // ),
            ),
          ],
        );
  }

  Widget _descripcion(PublicationProvider publicationProvider) {

    TextEditingController controller = TextEditingController(text: publicationProvider.getDescription);

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
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 0, left: 0, bottom: 0),
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (input) => publicationProvider.setDescription(input),
                ),
              ),
            ),
          ],
        );

  }

  Widget _condiciones(PublicationProvider publicationProvider) {

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

                  controller.clear();

                  final List<String> aux2 = publicationProvider.getConditions;

                  aux2.add(aux);

                  publicationProvider.setConditions(aux2);

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

    return Consumer<PublicationProvider>(
      builder: (_, provider, __){

      final List<String> lista =  provider.getConditions;


        if (lista.isNotEmpty) {

          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int index) {

              int indice = index;

            return Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 250,
                    child: Text(lista[index])
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
                          
                          String aux = lista[indice];

                          lista.remove(aux);

                          provider.setConditions(lista);

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
    );
    
  }

  Widget _imagenes(PublicationProvider publicationProvider) {

    Color color1 = Color.fromRGBO(0, 150, 136, 1);
    Color color2 = Color.fromRGBO(142, 142, 142, 1);

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
                  child: Consumer<PublicationProvider>(
                    builder:(_, provider, __) => FloatingActionButton(
                      
                      heroTag: null,
                      backgroundColor: provider.getprincipalImage == null ? color1 : color2 ,
                      child: Icon(Icons.cloud_upload, size: 25.0,),
                      onPressed: () async {
                        if (provider.getprincipalImage == null) {
                          _imagePrincipal = await ImagePicker.pickImage(source: ImageSource.gallery);
                          if (await _imagePrincipal.exists()) {
                            provider.setPrincipalImage(_imagePrincipal.path);
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Consumer<PublicationProvider>(
          builder:(_, provider, __) {
            if (provider.getprincipalImage != null) {
              return Container(
                margin: EdgeInsets.only(top: 10, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 250,
                      child: Text(provider.getprincipalImage)
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
                            provider.setPrincipalImage(null);
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
        ),

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
                  child: Consumer<PublicationProvider>(
                    builder: (_, provider, __) => FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Color.fromRGBO(0, 150, 136, 1),
                      child: Icon(Icons.cloud_upload, size: 25.0,),
                      onPressed: () async{
                          _imageExtra = await ImagePicker.pickImage(source: ImageSource.gallery);
                          if (await _imageExtra.exists()) {
                            List<File> aux = provider.getNewImages;
                            aux.add(_imageExtra);
                            provider.setNewImages(aux);
                          }
                      },
                    ),
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


    return Consumer<PublicationProvider>(
      builder: (_, provider, __) {

        final List<model.Image> images =  provider.getImages;
        final List<File> newImages =  provider.getNewImages;

        final List<String> lista = List();

        for (var i = 0; i < images.length; i++) {
          lista.add(images[i].path);
        }

        for (var i = 0; i < newImages.length; i++) {
          lista.add(newImages[i].path);
        }

        if (lista.isNotEmpty) {

          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int index) {

              int indice = index;
              
              return Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 250,
                      child: Text(lista[index]),
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
                            String aux = lista[indice];

                            // images.removeWhere((image) => image.path == aux);
                            provider.removeImage(aux);
                            newImages.removeWhere((image) => image.path == aux);

                            provider.setImages(images);
                            provider.setNewImages(newImages);
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
    );
  }

  Widget _botones(context, PublicationProvider publicationProvider) {

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
            child: Text('Cancelar', style: TextStyle(fontSize: 18),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onPressed: (){
              Navigator.pop(context);
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
            child: Text('Guardar', style: TextStyle(fontSize: 18),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onPressed: (){
              formKey.currentState.save();
              publicationProvider.editarPublicacion(_imagePrincipal);

              Navigator.pop(context);

            },
          ),
        ),
      ],
    );
  }
}