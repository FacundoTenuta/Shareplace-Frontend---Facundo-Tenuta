
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shareplace_flutter/src/models/requestion_model.dart';
import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:shareplace_flutter/src/providers/requestion_provider.dart';


class ListaSolicitudesRecibidas extends StatefulWidget {
  ListaSolicitudesRecibidas({Key key}) : super(key: key);

  @override
  _ListaSolicitudesRecibidasState createState() => _ListaSolicitudesRecibidasState();
}

class _ListaSolicitudesRecibidasState extends State<ListaSolicitudesRecibidas> {

  final prefs = PreferenciasUsuario();

  final requestionsProvider = new RequestionProvider();

  List<Requestion> _received = new List<Requestion>();

  ScrollController _scrollController = new ScrollController();

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
    
    _cargarSolicitudes();

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
    return RefreshIndicator(
      onRefresh: obtenerPagina1,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
        controller: _scrollController,
        itemCount: _received.length,
        itemBuilder: (BuildContext context, int index){
          return _request(context, _received[index]);
        },
      ),
    );
  }

  Future<Null> obtenerPagina1() async {


      _received.clear();
      _page = 1;
      _cargarSolicitudes();

  }

  void _cargarSolicitudes() async{

    final resp = await requestionsProvider.cargarRequestionsRecibidas(prefs.user, _page);

    if (resp.isNotEmpty) {
      for (var i = 0; i < resp.length; i++) {
        if (!_received.contains(resp[i])) {
          _received.add(resp[i]);
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

    _cargarSolicitudes();
  }

  Widget _request(BuildContext context, Requestion solicitud){

    String fecha = DateFormat('dd/MM/yyyy').format(solicitud.createdAt);

    print(fecha);
    
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(solicitud.title),
              Text(fecha),
              SizedBox(
                width: 22.0,
                height: 22.0,
                child: FloatingActionButton(
                  heroTag: "btnr" + solicitud.id.toString(),
                  backgroundColor: Color.fromRGBO(206, 80, 80, 1),
                  child: Icon(Icons.clear, size: 20.0,),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Divider()
        ],
      ),
    );
  }

}