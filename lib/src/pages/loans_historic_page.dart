
import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/models/requestion_model.dart';
import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:shareplace_flutter/src/providers/requestion_provider.dart';
import 'package:shareplace_flutter/src/search/search_delegate.dart';
import 'package:shareplace_flutter/src/widgets/menu_widget.dart';



class LoansHistoricPage extends StatefulWidget {
  @override
  _LoansHistoricPageState createState() => _LoansHistoricPageState();
}

class _LoansHistoricPageState extends State<LoansHistoricPage> {

  final publicationsProvider = new RequestionProvider();

  ScrollController _scrollController = new ScrollController();

  List<Requestion> _loans = new List<Requestion>();

  final prefs = PreferenciasUsuario();

  int _page = 1;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    
    _cargarPrestamos();

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
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 241, 246, 1),
      drawer: MenuWidget(),
      appBar: AppBar(
        elevation: 12.0,
        backgroundColor: Color.fromRGBO(125, 201, 231, 1),
        title: Text('Historial de Prestamos'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(
                context: context,
                delegate: DataSearch(),
                // query: 'asdads'
              );
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          _crearLista(),
          _listaVacia(),
          _crearLoading(),
        ],
      )
    );
  }


  Widget _crearLista(){

    return RefreshIndicator(
      onRefresh: obtenerPagina1,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
        controller: _scrollController,
        itemCount: _loans.length,
        itemBuilder: (BuildContext context, int index){
          return _loan(context, _loans[index]);
        },
      ),
    );

  }


  Future<Null> obtenerPagina1() async {


      _loans.clear();
      _page = 1;
      _cargarPrestamos();

  }

  void _cargarPrestamos() async{

    final resp = await publicationsProvider.cargarLoans(prefs.user, _page);

    print(resp.isNotEmpty);

    if (resp.isNotEmpty) {
      for (var i = 0; i < resp.length; i++) {
        print(!_loans.contains(resp[i]));
        if (!_loans.contains(resp[i])) {
          _loans.add(resp[i]);
        } 
      }
      if (resp.length == 10) {
        _page++;
      }
    }

    setState(() {
      
    });

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

    _cargarPrestamos();
  }

  Widget _crearLoading() {

    if (_isLoading) {
      return  Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator()
            ],
          ),
          SizedBox(height: 15.0)
          
        ],
      );
      
      
    } else{
      return Container();
    }

  }

  Widget _loan(BuildContext context, Requestion loan) {

    // final size = MediaQuery.of(context).size;

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: <BoxShadow> [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 2.0,
                )
              ]
            
            ),
        child: ClipRRect(
          
          borderRadius: BorderRadius.circular(15.0),
          child: Row(
            children: <Widget>[
              FadeInImage(
                  // image: NetworkImage(publi.principalImage),
                  image: AssetImage('assets/camara.jpg'),
                  placeholder: AssetImage('assets/24.gif'),
                  fadeInDuration: Duration(milliseconds: 150),
                  height: 100.0,
                  width: 160.0,
                  fit: BoxFit.cover,
              ),
              Column(
                
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(loan.title.toString()),
                  
                  Text(loan.id.toString())
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.pushNamed(context, 'publicationDetail', arguments: loan);
      },
    );
  }

  Widget _listaVacia(){

    if (_loans.isEmpty) {
      return Text('No posee publicaciones');
    }else{
      return Container();
    }

  }

}