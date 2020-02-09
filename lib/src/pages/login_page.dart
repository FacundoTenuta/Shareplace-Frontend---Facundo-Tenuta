import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shareplace_flutter/src/models/user_model.dart';
import 'package:shareplace_flutter/src/providers/user_provider.dart';
import 'package:shareplace_flutter/src/utils/utils.dart' as utils;

class LoginPage extends StatelessWidget {

  final formKey = GlobalKey<FormState>();

  String _user, _password;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context, user),
        ],
      )
    );
  }

  Widget _crearFondo(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 1,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color> [
            Color.fromRGBO(125, 201, 231, 1.0),
            Color.fromRGBO(176, 155, 248, 1.0)
          ]
        )
      ),
    );

    return fondoMorado;

  }

  Widget _loginForm(BuildContext context, UserProvider user) {

    final size = MediaQuery.of(context).size;

    return Form(
      key: formKey,
      child: Column(
          children: <Widget>[

            SafeArea(
              child: Container(
                height: size.height * 0.15,
              ),
            ),


            Column(
                children: <Widget>[
                  Text('Shareplace', style: TextStyle(fontSize: 55.0, color: Color.fromRGBO(46, 41, 172, 1))),
                  SizedBox(height: size.height * 0.09),
                  _crearDni(user),
                  SizedBox(height: size.height * 0.07),
                  _crearPassword(user),
                  SizedBox(height: size.height * 0.07),
                  Text('¿Olvidaste tu contraseña?'),
                  SizedBox(height: size.height * 0.1),
                  _crearBoton(user, context),
                ],
              ),
  

          ],
        ),
    );
    

  }

  Widget _crearDni(UserProvider user) {

    return 

        Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'DNI',
            ),
            onSaved: (input) => _user = input,
          ),
        );

      }
    

  

  Widget _crearPassword(UserProvider user) {

        return 
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: TextFormField(
            
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
            ),
            onSaved: (input) => _password = input,
          ),
        );
      }


  Widget _crearBoton(UserProvider user, BuildContext context){

        return 
        RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Iniciar Sesión', style: TextStyle(fontSize: 14)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Color.fromRGBO(46, 41, 172, 1),
          textColor: Colors.white,
          onPressed: 
          () => _login(user, context),
          
        );
  }
    
  

  _login(UserProvider userProvider, BuildContext context) async {

    formKey.currentState.save();

    Map info = await userProvider.login(_user, _password);

    if (info['ok']) {

      Navigator.pushReplacementNamed(context, 'home');

      

    }else{

      utils.mostrarAlerta(context, info['mensaje']);

    }

  }

}
