
import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/widgets/menu_widget.dart';



class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 241, 246, 1),
      drawer: MenuWidget(),
      appBar: AppBar(
        elevation: 12.0,
        backgroundColor: Color.fromRGBO(125, 201, 231, 1),
        title: Text('Shareplace'),
        centerTitle: true,
      ),
    );
  }
}