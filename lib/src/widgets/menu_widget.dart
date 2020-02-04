


import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/bloc/provider.dart';

class MenuWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.getMenuBloc(context);

    final size = MediaQuery.of(context).size;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[

          Container(
            height: size.height * 0.3,
            child: DrawerHeader(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    StreamBuilder(
                      stream: bloc.avatarStream ,
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                        return Container(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage('http://10.0.2.2/shareplace-backend---facundo-tenuta/public/img/${bloc.avatar}'),
                            radius: 50.0,
                          ),
                        );
                      },
                    ),
                    StreamBuilder(
                      stream: bloc.usernameStream,
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                        return Container(
                          child: Text(bloc.username),
                        );
                      },
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(125, 201, 231, 1)
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: ()=> Navigator.pushNamed(context, 'home'),
          ),

          ListTile(
            leading: Icon(Icons.event_note),
            title: Text('Mis Publicaciones'),
            onTap: ()=> Navigator.pushNamed(context, 'myPublications'),
          ),

          ListTile(
            leading: Icon(Icons.repeat),
            title: Text('Prestamos'),
            onTap: ()=> Navigator.pushNamed(context, 'loans'),
          ),

          ListTile(
            leading: Icon(Icons.restore),
            title: Text('Historial de Prestamos'),
            onTap: ()=> Navigator.pushNamed(context, 'loansHistoric'),
          ),

          ListTile(
            leading: Icon(Icons.description),
            title: Text('Solicitudes'),
            onTap: ()=> Navigator.pushNamed(context, 'requests'),
          ),

          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Mi Perfil'),
            onTap: ()=> Navigator.pushNamed(context, 'profile'),
            // onTap: ()=>  Navigator.,
          ),

          ListTile(
            leading: Icon(Icons.help),
            title: Text('Acerca de Shareplace'),
            onTap: ()=> Navigator.pushNamed(context, 'info'),
          ),

          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Cerrar Sesion'),
            onTap: ()=> Navigator.pushNamed(context, 'login'),
          ),
        ],
      ),
    );

  }
}


