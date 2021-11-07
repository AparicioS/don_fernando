import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:don_fernando/don_fernando/model/estabelecimento.dart';
import 'package:don_fernando/don_fernando/model/produto.dart';

class Estoque {
  Produto produto;
  int quantidade;

  Estoque.novo(){this.produto = Produto.novo();}
  Estoque(this.produto,this.quantidade);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['quantidade'] = quantidade;
    return map;
  }

  Estoque.fromDoc(QueryDocumentSnapshot doc)  {
    if (doc != null) {
      Map<String, dynamic> map = doc.data();             
      this.produto= Estabelecimento().produtos.singleWhere((entity) => entity.id == doc.id)??Produto.novo();
      this.quantidade = map['quantidade'];
    }
  }
  setProduto(Produto prod){
    this.produto = prod;
  }

}