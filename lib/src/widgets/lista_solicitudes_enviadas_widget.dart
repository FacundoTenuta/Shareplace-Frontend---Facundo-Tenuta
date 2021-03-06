
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shareplace_flutter/src/models/requestion_model.dart';
import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:shareplace_flutter/src/providers/requestion_provider.dart';
import 'package:shareplace_flutter/src/utils/utils.dart' as utils;


class ListaSolicitudesEnviadas extends StatefulWidget {
  ListaSolicitudesEnviadas({Key key}) : super(key: key);

  @override
  _ListaSolicitudesEnviadasState createState() => _ListaSolicitudesEnviadasState();
}

class _ListaSolicitudesEnviadasState extends State<ListaSolicitudesEnviadas> {

  final prefs = PreferenciasUsuario();

  final requestionsProvider = new RequestionProvider();

  List<Requestion> _sent = new List<Requestion>();

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
    if (_sent.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: obtenerPagina1,
        child: ListView.builder(
          padding: EdgeInsets.only(left: 30, right: 30, top: 10),
          controller: _scrollController,
          itemCount: _sent.length,
          itemBuilder: (BuildContext context, int index){
            return _request(context, _sent[index]);
          },
        ),
      );
    }else{
      return Center(child: Text('No posee solicitudes emitidas'));
    }
  }

  Future<Null> obtenerPagina1() async {


      _sent.clear();
      _page = 1;
      _cargarSolicitudes();

  }

  void _cargarSolicitudes() async{

    final resp = await requestionsProvider.cargarRequestionsEnviadas(prefs.user, _page);

    if (resp.isNotEmpty) {
      for (var i = 0; i < resp.length; i++) {
        if (!_sent.contains(resp[i])) {
          _sent.add(resp[i]);
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

    int id = solicitud.id;

    return GestureDetector(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top:5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(solicitud.title),
                  Text(fecha),
                  SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: FloatingActionButton(
                      heroTag: "btns" + solicitud.id.toString(),
                      backgroundColor: Color.fromRGBO(206, 80, 80, 1),
                      child: Icon(Icons.clear, size: 20.0,),
                      onPressed: () async{
                        String respuesta = await RequestionProvider().eliminarSolicitud(id);
                        this.obtenerPagina1();
                        setState(() {
                          
                        });
                        if (respuesta == '200') {

                          utils.mostrarAlerta(context, 'Solicitud', 'La solicitud se elimino correctamente.');

                        }else{

                          utils.mostrarAlerta(context, 'Ops! Algo salió mal', 'Hubo un problema al eliminar la solicitud.');

                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider()
          ],
        ),
      ),
      onTap: (){
        Navigator.pushNamed(context, 'requestSentDetail', arguments: solicitud);
      },
    );
  }


}