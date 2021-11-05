import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:don_fernando/don_fernando/model/estabelecimento.dart';
import 'package:don_fernando/don_fernando/model/produto.dart';

class ControllerProduto {

  static cadastrarProduto(Produto produto) {
    if (Estabelecimento().id == null) {
      return 'Falha ';
    }
    if (produto.id == null) {
      produto.id = (Estabelecimento().produtos.length +1).toString();
    }
    return FirebaseFirestore.instance
        .collection('Estabelecimento')
        .doc(Estabelecimento().id)
        .collection('Produto')
        .doc(produto.id)
        .set(produto.toMap())
        .then((value) => 'Sucesso ')
        .catchError((erro) => 'Falha ');
  }

  static Future<Produto> buscaProduto(String codigo)  async {
    Produto produto;
    await FirebaseFirestore.instance
        .collection('Estabelecimento')
        .doc(Estabelecimento().id)
        .collection('Produto')
        .doc(codigo)
        .get()
        .then((value) {
          if (value != null) {
              produto = Produto.fromMap(value.data());
              produto.id = value.id;
          }
          return produto;
        });
    return produto;
  }

  static List<Produto> buscarProdutosFromCategoria(String categoria) {
    List<Produto> produtos = [];
    FirebaseFirestore.instance.collection('Estabelecimento')
        .doc(Estabelecimento().id)
        .collection('Produto').where("categoria"==categoria).get().then((value) {
      produtos.addAll(value.docs.map((doc) => Produto.fromDoc(doc)).toList());
      return produtos;
    }).asStream();
    return produtos;
  }
  
  static Future<List<Produto>> buscarProdutos() async {
    List<Produto> produtos = [];
    await FirebaseFirestore.instance.collection('Estabelecimento')
          .doc(Estabelecimento().id)
          .collection('Produto')
          .orderBy("categoria")
          .get().then((value) {
              produtos.addAll(value.docs.map((doc) => Produto.fromDoc(doc)).toList()); 
    });
    return produtos;
    
  }
}