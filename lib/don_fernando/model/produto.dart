import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  String id;
  String categoria;
  String descricao;
  String valor;
  String unidade;
  String composicao;

  Produto.novo();

  Produto(this.id,this.categoria,this.descricao, this.valor, this.unidade,this.composicao);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['categoria'] = categoria;
    map['descricao'] = descricao;
    map['valor'] = valor;
    map['unidade'] = unidade;
    map['composicao'] = composicao;

    return map;
  }

  Produto.fromDoc(QueryDocumentSnapshot doc) {
    if (doc != null) {
      Map<String, dynamic> map = doc.data();
      this.id = doc.id;
      this.categoria = map['categoria'];
      this.descricao = map['descricao'];
      this.valor = map['valor'];
      this.unidade = map['unidade'];
      this.composicao = map['composicao'];
    }
  }

  Produto.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      this.categoria = map['categoria'];
      this.descricao = map['descricao'];
      this.valor = map['valor'];
      this.unidade = map['unidade'];
      this.composicao = map['composicao'];
    }
  }  
}