




import 'package:rxdart/rxdart.dart';
import 'package:shareplace_flutter/src/models/publication_model.dart';
// import 'package:shareplace_flutter/src/providers/publication_provider.dart';

class PublicationBloc{


  final _publicationsController = BehaviorSubject<List<Publication>>();

  // final _publicationsProvider = new PublicationProvider();

  Stream<List<Publication>> get publicationsStream     => _publicationsController.stream;

  List<Publication> get publications => _publicationsController.value;

  void cargarPublications() async {

    // List<Publication> publis = List();
    // final publis = await _publicationsProvider.cargarPublications();
    // _publicationsController.sink.add(publis);

  }

  dispose(){
    _publicationsController?.close();
  }

}