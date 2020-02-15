import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/models/argumentos_other_profile_model.dart';
import 'package:shareplace_flutter/src/models/publication_model.dart';
import 'package:shareplace_flutter/src/providers/busquedas_provider.dart';
import 'package:shareplace_flutter/src/widgets/resultados_widget.dart';



class DataSearch extends SearchDelegate{

  String seleccion = '';
  final busquedasProvider = new BusquedasProvider();

  // final peliculas = [
  //   'Spiderman',
  //   'Aquaman',
  //   'Batman',
  //   'Shazam',
  //   'Ironman',
  //   'Capitan America',
  // ];

  // final peliculasRecientes = [
  //   'Spiderman',
  //   'Capitan America'
  // ];



  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    if (query.isEmpty) {
      return Container();
    }else{
      return Resultados(query);
    }

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe

    if (query.isEmpty) {
      return Container();
    }

    String url = 'http://10.0.2.2/shareplace-backend---facundo-tenuta/public/img/';

    return FutureBuilder(
      future: busquedasProvider.buscarPublication(query, 1),
      builder: (BuildContext context, AsyncSnapshot<List<Publication>> snapshot) {
        
        if (snapshot.hasData) {

          final publications = snapshot.data;
          
          return ListView(
            children: publications.map((publication){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(url + publication.principalImage),
                  // image: AssetImage('assets/camara.jpg'),
                  placeholder: AssetImage('assets/img/loading.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(publication.title.toString()),
                // subtitle: Text(publication.originalTitle),
                onTap: (){
                  close(context, null);
                  ArgumentosOtherProfile arg = ArgumentosOtherProfile(publication, true);
                  // publication.uniqueId = '';
                  Navigator.pushNamed(context, 'publicationDetail', arguments: arg);
                },
              );
            }).toList(),
          );

        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }

      },
    );

  }

}