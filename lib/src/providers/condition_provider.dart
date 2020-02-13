import 'package:flutter/material.dart';
import 'package:shareplace_flutter/src/models/publication_model.dart';




class ConditionProvider with ChangeNotifier {


  List<Condition> _user;

  List<Condition> get getUser {
    return _user;
  }

  void setUser( user ){
    this._user = user;

    notifyListeners();
  }


}