
import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/models/publication_model.dart';
import 'package:shareplace_flutter/src/models/requestion_model.dart';
import 'package:shareplace_flutter/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:shareplace_flutter/src/providers/publication_provider.dart';
import 'package:shareplace_flutter/src/providers/requestion_provider.dart';
import 'package:shareplace_flutter/src/search/search_delegate.dart';
import 'package:shareplace_flutter/src/widgets/menu_widget.dart';



class LoansPage extends StatefulWidget {

  @override
  _LoansPageState createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
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
        title: Text('Prestamos'),
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

    if (resp.isNotEmpty) {
      for (var i = 0; i < resp.length; i++) {
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
              _loanImage(loan.publicationId),
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  _flechas(loan.requesterId),
                  
                  Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(loan.title.toString())
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 19),
                        child: _botonFinalizar(loan.id),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.pushNamed(context, 'loanDetail', arguments: loan);
      },
    );
  }

  Widget _loanImage(int publicationId) {

    Future<Publication> publi = PublicationProvider().obtenerPublicacion(publicationId);

    return FutureBuilder(
      future: publi,
      builder: (BuildContext context, AsyncSnapshot<Publication> snapshot) {
        if (snapshot.hasData) {
          return FadeInImage(
            image: NetworkImage('http://10.0.2.2/shareplace-backend---facundo-tenuta/public/img/${snapshot.data.principalImage}'),
            placeholder: AssetImage('assets/24.gif'),
            fadeInDuration: Duration(milliseconds: 150),
            height: 100.0,
            width: 160.0,
            fit: BoxFit.cover,
          );
        }else{
          return Container(
            height: 100.0,
            width: 160.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
        
      },
    );

    
  }

  Widget _flechas(int requesterId) {

    if (requesterId == prefs.user) {
      return Row(
        children: <Widget>[
          Icon(Icons.arrow_back_ios, size: 90, color: Color.fromRGBO(0, 200, 0, 0.09)),
          Icon(Icons.arrow_back_ios, size: 90, color: Color.fromRGBO(0, 200, 0, 0.09)),
        ],
      );
    }else{
      return Row(
        children: <Widget>[
          Icon(Icons.arrow_forward_ios, size: 90, color: Color.fromRGBO(200, 0, 0, 0.09)),
          Icon(Icons.arrow_forward_ios, size: 90, color: Color.fromRGBO(200, 0, 0, 0.09)),
        ],
      );
    }
  }

  Widget _listaVacia(){

    if (_loans.isEmpty) {
      return Center(child: Text('No posee prestamos activos'));
    }else{
      return Container();
    }

  }

  Widget _botonFinalizar(int id) {

    return ButtonTheme(
              minWidth: 130.0,
              height: 30.0,
              child: RaisedButton(
                padding: EdgeInsets.only(right: 15, left: 15),
                textColor: Colors.white,
                // color: color,
                child: Text('Finalizar prestamo', style: TextStyle(fontSize: 12),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: (){
                  RequestionProvider().finalizarPrestamo(id);
                  Navigator.popAndPushNamed(context, 'loans');
                },
              ),
            );

  }
}