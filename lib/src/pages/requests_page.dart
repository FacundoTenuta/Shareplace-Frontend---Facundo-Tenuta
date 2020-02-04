
import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/search/search_delegate.dart';
import 'package:shareplace_flutter/src/widgets/lista_solicitudes_enviadas_widget.dart';
import 'package:shareplace_flutter/src/widgets/lista_solicitudes_recibidas_widget.dart';
import 'package:shareplace_flutter/src/widgets/menu_widget.dart';



class RequestsPage extends StatefulWidget {
  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(229, 241, 246, 1),
        drawer: MenuWidget(),
        appBar: _appBar(),
        body: TabBarView(
          
          controller: _tabController,
          children: <Widget>[
            ListaSolicitudesRecibidas(),
            ListaSolicitudesEnviadas(),
          ],
        ),
      ),
    );
  }

  Widget _appBar(){
    return AppBar(
      elevation: 12.0,
      backgroundColor: Color.fromRGBO(125, 201, 231, 1),
      title: Text('Solicitudes'),
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
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: Color.fromRGBO(255, 255, 141, 1),
        indicatorWeight: 2,
        tabs: <Widget>[
          Tab(
            child: Container(
              child: Text('Recibidas'),
            )
          ),
          Tab(
            child: Container(
              child: Text('Emitidas'),
            )
          ),
        ],
      ),
    );
  }

}