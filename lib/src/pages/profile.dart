
// import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// import 'package:shareplace_flutter/src/bloc/menu_bloc.dart';
import 'package:shareplace_flutter/src/models/user_model.dart';
import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:shareplace_flutter/src/providers/avatar_provider.dart';
import 'package:shareplace_flutter/src/providers/user_provider.dart';



class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }


  ProfilePage(){
    
  }

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
final prefs = PreferenciasUsuario();

  final formKey = GlobalKey<FormState>();

  File _imageNueva;

  Future<User> user;

  String _name, _lastName, _mail, _phone, _description, _birthDate;

  String _image;

  @override
  Widget build(BuildContext context) {

    // final avatarProvider = Provider.of<AvatarProvider>(context, listen: false);

    // UserProvider user = Provider.of<UserProvider>(context, listen: false);
    // _name = user.getUser.name;
    // _lastName = user.getUser.lastName;
    // _mail = user.getUser.email;
    // _phone = user.getUser.phone.toString();
    // _description = user.getUser.description;
    // _image = user.getUser.image;

    // final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 241, 246, 1),
      appBar: AppBar(
        elevation: 12.0,
        backgroundColor: Color.fromRGBO(125, 201, 231, 1),
        title: Text('Perfil'),
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
      body: Stack(
          children: <Widget>[
            _perfil(context),
          ],
        ),
    );
  }

  Widget _perfil(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context, listen: false);


    user = userProvider.cargarUsuario(prefs.user);


    return FutureBuilder(
      future: user,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {

        

        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _avatar(snapshot),
                    _nombre(snapshot),
                    SizedBox(height: 30.0),
                    _apellido(snapshot),
                    SizedBox(height: 30.0),
                    _email(snapshot),
                    SizedBox(height: 30.0),
                    _telefono(snapshot),
                    SizedBox(height: 30.0),
                    // _nacimiento(snapshot),
                    // SizedBox(height: 30.0),
                    _dni(snapshot),
                    SizedBox(height: 30.0),
                    _descripcion(snapshot),
                    SizedBox(height: 30.0),
                    _botonAceptar(context, snapshot, userProvider),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            ),
          );
        }else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
      }
    );
  }
    

  

  Widget _botonAceptar( BuildContext context, AsyncSnapshot<User> snapshot, UserProvider userProvider) {
    return Container(
      child: ButtonTheme(
        minWidth: 130.0,
        height: 50.0,
        child: RaisedButton(
          padding: EdgeInsets.only(right: 10, left: 10),
          textColor: Colors.white,
          color: Color.fromRGBO(26, 176, 181, 1),
          child: Text('Aceptar', style: TextStyle(fontSize: 18),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          onPressed: (){
            formKey.currentState.save();
            userProvider.editarUsuario(_name, _lastName, _mail, _phone, _description, _imageNueva);
          },
        ),
      )
    );

  }

  Widget _nombre(AsyncSnapshot<User> snapshot) {

    TextEditingController asd = TextEditingController(text: snapshot.data.name);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: asd,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.edit, size: 30,),
          border: OutlineInputBorder(),
          labelText: 'Nombre',
        ),
        onSaved: (input) => _name = input,
      ),
    );
    
  }

  Widget _apellido(AsyncSnapshot<User> snapshot) {

    TextEditingController asd = TextEditingController(text: snapshot.data.lastName);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: asd,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.edit, size: 30,),
          border: OutlineInputBorder(),
          labelText: 'Apellido',
        ),
        onSaved: (input) => _lastName = input,
      ),
    );
    
  }

  Widget _email(AsyncSnapshot<User> snapshot) {

    TextEditingController asd = TextEditingController(text: snapshot.data.email);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: asd,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.edit, size: 30,),
          border: OutlineInputBorder(),
          labelText: 'Correo electronico',
        ),
        onSaved: (input) => _mail = input,
      ),
    );
    
  }

  Widget _telefono(AsyncSnapshot<User> snapshot) {

      TextEditingController asd;
    

    if (snapshot.data.phone != 'null') {
      asd = TextEditingController(text: snapshot.data.phone);
      print('asdad');
      print(snapshot.data.phone);
    }else{
      asd = TextEditingController(text: '');
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: asd,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.edit, size: 30,),
          border: OutlineInputBorder(),
          hintText: 'Ingrese su telefono',
          labelText: 'Telefono',
        ),
        onSaved: (input) => _phone = input,
      ),
    );
    
  }

  // Widget _nacimiento() {

  //   if (_birthDate.toString() != 'null') {
  //     TextEditingController asd = TextEditingController(text: _birthDate.toString());
  //   }else{
  //     TextEditingController asd = TextEditingController(text: ' ');
  //   }

  //   // TextEditingController asd = TextEditingController(text: _birthDate.toString());

  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 20.0),
  //     child: TextField(
  //       // controller: asd,
  //       keyboardType: TextInputType.text,
  //       decoration: InputDecoration(
  //         suffixIcon: Icon(Icons.edit, size: 30,),
  //         border: OutlineInputBorder(),
  //         labelText: 'Fecha de nacimiento',
  //       ),
  //     ),
  //   );
    
  // }

  Widget _dni(AsyncSnapshot<User> snapshot) {

    TextEditingController asd = TextEditingController(text: snapshot.data.dni.toString());

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: asd,
        keyboardType: TextInputType.text,
        enabled: false,
        decoration: InputDecoration(
          // suffixIcon: Icon(Icons.edit, size: 30,),
          border: OutlineInputBorder(),
          labelText: 'DNI',
        ),
      ),
    );
    
  }

  Widget _avatar(AsyncSnapshot<User> snapshot) {


    ImageProvider imagen;

    print(_image);

    if (_image == null) {
      imagen = NetworkImage('http://10.0.2.2/shareplace-backend---facundo-tenuta/public/img/' + snapshot.data.image);
    }else{
      imagen = FileImage(_imageNueva);
    }

    print('se redibuja?');

    return Container(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Stack(
        children: <Widget>[
            CircleAvatar(
              backgroundImage: imagen,
              radius: 80.0,
            ),
          Positioned(
            right: 0,
            bottom: 0,
            child: FloatingActionButton(
              backgroundColor: Color.fromRGBO(0, 150, 136, 1),
              heroTag: 'btnavatar',
              child: Icon(Icons.camera_alt),
              onPressed: () async {
                _imageNueva = await ImagePicker.pickImage(source: ImageSource.gallery);
                  print(_image);
                setState(() {
                  if (_imageNueva != null) {
                    _image = _imageNueva.path;
                  }
                });
                print(_image);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _descripcion(AsyncSnapshot<User> snapshot) {

    TextEditingController asd;

    if (snapshot.data.description == 'null') {
      asd = TextEditingController(text: snapshot.data.description);
    }else{
      asd = TextEditingController(text: '');
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        maxLines: null,

        controller: asd,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.edit, size: 30,),
          border: OutlineInputBorder(),
          labelText: 'Descripción',
          hintText: 'Conocimientos, habilidades, enlaces a paginas webs y demás',
        ),
        onSaved: (input) => _description = input,
      ),
    );

  }

  void _seleccionarAvatar() async {

    _imageNueva = await ImagePicker.pickImage(source: ImageSource.gallery);

    // avatarProvider.setAvatar(_imageNueva.path);

 
  }
}