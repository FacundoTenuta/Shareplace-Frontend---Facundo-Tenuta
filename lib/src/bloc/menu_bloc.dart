




import 'package:rxdart/rxdart.dart';

class MenuBloc{


  final _avatarController     = BehaviorSubject<String>();
  final _usernameController   = BehaviorSubject<String>();


  // Recuperar los datos del Stream
  Stream<String> get avatarStream     => _avatarController.stream;
  Stream<String> get usernameStream   => _usernameController.stream;

  // Insertar valores al Stream
  // Function(String) get changeAvatar     => _avatarController.sink.add;
  // Function(String) get changeUsername   => _usernameController.sink.add;

  void cargarDatos(String avatar, String username){
    _avatarController.sink.add(avatar);
    _usernameController.sink.add(username);
  }

  // Obtener el último valor ingresado a los streams
  String get avatar      => _avatarController.value;
  String get username    => _usernameController.value;

  dispose(){
    _avatarController?.close();
    _usernameController?.close();
  }

}