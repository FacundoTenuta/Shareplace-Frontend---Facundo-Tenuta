import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/widgets/menu_widget.dart';


class InicioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(125, 201, 231, 1),
        title: Text('Home'),
        centerTitle: true,
      ),
    );
  }
}