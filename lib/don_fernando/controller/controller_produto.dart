import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:don_fernando/don_fernando/model/estabelecimento.dart';
import 'package:don_fernando/don_fernando/model/produto.dart';

class ControllerProduto {
  static cadastrarProduto(Produto produto) {
    if (Estabelecimento().id == null) {
      return 'Falha ';
    }
    
    return FirebaseFirestore.instance
        .collection('Estabelecimento')
        .doc(Estabelecimento().id)
        .collection('Estoque')
        .doc(produto.id)
        .set(produto.toMap())
        .then((value) => 'Sucesso ')
        .catchError((erro) => 'Falha ');
  }
}