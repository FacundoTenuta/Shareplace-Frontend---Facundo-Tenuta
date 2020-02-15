
import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/models/argumentos_other_profile_model.dart';
import 'package:shareplace_flutter/src/models/publication_model.dart';
import 'package:shareplace_flutter/src/providers/busquedas_provider.dart';

class Resultados extends StatefulWidget {
  final String query;
  Resultados(this.query, {Key key}) : super(key: key);

  @override
  _ResultadosState createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {

  final busquedasProvider = new BusquedasProvider();

  ScrollController _scrollController = new ScrollController();

  List<Publication> _resultados = new List<Publication>();

  int _page = 1;
  bool _isLoading = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }    
  }

  @override
  void initState() {
    super.initState();
    
    _cargarRespuesta();

    _scrollController.addListener((){

      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchData();
      }

    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    if (_resultados.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: obtenerPagina1,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _resultados.length,
          itemBuilder: (BuildContext context, int index){
            return _resultado(context, _resultados[index]);
          },          
        ),
      );
    }else{
      return Center(child: Text('No se encontraron resultados'));
    }
  }

  _resultado(BuildContext context, Publication resultado){

    String url = 'http://10.0.2.2/shareplace-backend---facundo-tenuta/public/img/';

    return ListTile(
      contentPadding: EdgeInsets.all(20),
      leading: FadeInImage(
        image: NetworkImage(url + resultado.principalImage),
        placeholder: AssetImage('assets/img/loading.jpg'),
        width: 50.0,
        fit: BoxFit.contain,
      ),
      title: Text(resultado.title.toString()),
      onTap: (){
        ArgumentosOtherProfile arg = ArgumentosOtherProfile(resultado, true);
        Navigator.pushNamed(context, 'publicationDetail', arguments: arg);
      },
    );

  }

  Future<Null> obtenerPagina1() async {


      _resultados.clear();
      _page = 1;
      _cargarRespuesta();

  }

  Future fetchData() async{

    _isLoading = true;
    setState(() {
      
    });
    respuestaHTTP();

  }

  void respuestaHTTP(){
    _isLoading = false;
    
    _scrollController.animateTo(
      _scrollController.position.pixels + 100,
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 250)
    );
    _cargarRespuesta();
  }

  void _cargarRespuesta() async{

    final resp = await busquedasProvider.buscarPublication(widget.query, _page);

    if (resp.isNotEmpty) {
      for (var i = 0; i < resp.length; i++) {
        if (!_resultados.contains(resp[i])) {
          _resultados.add(resp[i]);
        } 
      }
      if (resp.length == 10) {
        _page++;
      }
    }

    // if (this.mounted) {
      setState(() {
      
      });
    // }

    

  }
}