



import 'package:shareplace_flutter/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{


  final _dniController      = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get dniStream      => _dniController.stream;
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream  => 
      CombineLatestStream.combine2(dniStream, passwordStream, (d, p) => true);

  // Insertar valores al Stream
  Function(String) get changeDni      => _dniController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;


  // Obtener el último valor ingresado a los streams
  String get dni      => _dniController.value;
  String get password => _passwordController.value;


  dispose(){
    _dniController?.close();
    _passwordController?.close();
  }

}

