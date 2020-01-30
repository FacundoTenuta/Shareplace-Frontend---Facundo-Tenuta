import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/bloc/login_bloc.dart';
import 'package:shareplace_flutter/src/bloc/menu_bloc.dart';
import 'package:shareplace_flutter/src/bloc/publication_bloc.dart';


class Provider extends InheritedWidget{

  static Provider _instancia;

  final loginBloc = LoginBloc();

  final menuBloc  = MenuBloc();

  final publicationsBloc = PublicationBloc();

  factory Provider({Key key, Widget child}){

    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }

    return _instancia;

  }

  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);

  

  // Provider({Key key, Widget child})
  //   : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc getLoginBloc (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static MenuBloc getMenuBloc (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>().menuBloc;
  }

  static PublicationBloc getPublicationsBloc (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>().publicationsBloc;
  }

}