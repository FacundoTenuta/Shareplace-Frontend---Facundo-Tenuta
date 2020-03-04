


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shareplace_flutter/src/pages/profile.dart';
import 'package:shareplace_flutter/src/providers/user_provider.dart';

class MenuWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

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
                          Container(
                            child: Consumer<UserProvider>(
                              builder: (_, user, __) => CircleAvatar(
                                backgroundImage: NetworkImage('http://10.0.2.2/shareplace-backend---facundo-tenuta/public/img/${user.getUser.image}'),
                                radius: 50.0,
                              ),
                            ),
                          ),
                          Container(
                            child: Consumer<UserProvider>(builder: (_, user, __ ) => Text(user.getUser.name + ' ' + user.getUser.lastName)),
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
              onTap: ()=> Navigator.push(context, new MaterialPageRoute(builder: (context) => new ProfilePage()),)
            ),

            ListTile(
              leading: Icon(Icons.help),
              title: Text('Acerca de Shareplace'),
              onTap: ()=> Navigator.pushNamed(context, 'info'),
            ),

            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Cerrar Sesion'),
              onTap: ()=> Navigator.pushNamedAndRemoveUntil(context, 'login', (Route<dynamic> route) => false),
            ),
          ],
        ),
      );
  }
}


