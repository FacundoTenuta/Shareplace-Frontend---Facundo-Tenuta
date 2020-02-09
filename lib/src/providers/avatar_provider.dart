import 'package:flutter/material.dart';


class AvatarProvider with ChangeNotifier{


  String _avatar;

  String get getAvatar {
    return _avatar;
  }

  void setAvatar( avatar ){
    this._avatar = avatar;

    notifyListeners();
  }


}