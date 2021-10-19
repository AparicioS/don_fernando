
import 'package:cloud_firestore/cloud_firestore.dart';

class ControllerEstabelecimento {
  static cadastrarEstabelecimento(estabelecimento) {
    if (estabelecimento == null) {
      return 'Falha ';
    }
    
    return FirebaseFirestore.instance
        .collection('Estabelecimento')
        .doc(estabelecimento.id)
        .set(estabelecimento.toMap())
        .then((value) => 'Sucesso ')
        .catchError((erro) => 'Falha ');
  }
}
