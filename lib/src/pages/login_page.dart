import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/bloc/login_bloc.dart';
import 'package:shareplace_flutter/src/bloc/provider.dart';
import 'package:shareplace_flutter/src/models/user_model.dart';
import 'package:shareplace_flutter/src/providers/usuario_provider.dart';
import 'package:shareplace_flutter/src/utils/utils.dart' as utils;

class LoginPage extends StatelessWidget {

  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
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

  Widget _loginForm(BuildContext context) {

    final bloc = Provider.getLoginBloc(context);
    final size = MediaQuery.of(context).size;

    return Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: size.height * 0.15,
            ),
          ),


          Column(
              children: <Widget>[
                Text('Shareplace', style: TextStyle(fontSize: 55.0, color: Color.fromRGBO(46, 41, 172, 1))),
                SizedBox(height: size.height * 0.05),
                _crearDni(bloc),
                SizedBox(height: size.height * 0.05),
                _crearPassword(bloc),
                SizedBox(height: size.height * 0.05),
                Text('¿Olvidaste tu contraseña?'),
                SizedBox(height: size.height * 0.05),
                _crearBoton(bloc),
              ],
            ),
  

        ],
      );
    

  }

  Widget _crearDni(LoginBloc bloc) {

    return StreamBuilder(
      stream:  bloc.dniStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'DNI',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeDni,
          ),
        );

      },
    );

  }

  Widget _crearPassword(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.passwordStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );

  }

  Widget _crearBoton(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Iniciar Sesión', style: TextStyle(fontSize: 14)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
          
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {

    Map info = await usuarioProvider.login(bloc.dni, bloc.password);

    if (info['ok']) {

      Navigator.pushReplacementNamed(context, 'inicio');

      print(info['user']);

      final user = User.fromJson(info['user']);
      Provider.getMenuBloc(context).cargarDatos(user.image, user.name + ' ' + user.lastName);

    }else{

      utils.mostrarAlerta(context, info['mensaje']);

    }

  }


}