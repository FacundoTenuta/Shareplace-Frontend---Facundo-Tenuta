
import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/search/search_delegate.dart';
import 'package:shareplace_flutter/src/widgets/menu_widget.dart';



class LoansPage extends StatelessWidget {
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
    );
  }
}