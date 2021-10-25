import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:don_fernando/don_fernando/controller/controller_produto.dart';
import 'package:don_fernando/don_fernando/model/estabelecimento.dart';
import 'package:don_fernando/don_fernando/model/estoque.dart';

class ControllerEstoque {

  static cadastrarEstoque(Estoque estoque) {
    if (Estabelecimento().id == null) {
      return 'Falha ';
    }    
    return FirebaseFirestore.instance
        .collection('Estabelecimento')
        .doc(Estabelecimento().id)
        .collection('Estoque')
        .doc(estoque.produto.id)
        .set(estoque.toMap())
        .then((value) => 'Sucesso ')
        .catchError((erro) => 'Falha ');
  }
  buscaProdutoEstoque(String codigo) async {
    Estoque estoque;
    FirebaseFirestore.instance
          .collection('Estabelecimento')
          .doc(Estabelecimento().id)
          .collection('Estoque')
          .doc(codigo)
          .snapshots()
          .map((value){
            Map<String, dynamic> dados = value.data();
            if (dados != null) {
              ControllerProduto.buscaProduto(value.id).then((value) => estoque = Estoque(value, dados['quantidade']));
            }
        });
        return estoque;
  }

  static Future<List<Estoque>> buscarEstoques() async {
    List<Estoque> listEstoque = [];
    await FirebaseFirestore.instance.collection('Estabelecimento')
        .doc(Estabelecimento().id)
        .collection('Estoque').get().then((value) {          
            listEstoque.addAll(value.docs.map((doc) => Estoque.fromDoc(doc)).toList());              
    });
    return listEstoque;
  }

}