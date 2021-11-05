import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:don_fernando/don_fernando/model/estabelecimento.dart';
import 'package:flutter/material.dart';

class Produto {
  String id;
  String categoria;
  String descricao;
  String valor;
  String unidade;
  Map composicao;

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
  static getDropdownMenuCategorias(){
        return Estabelecimento().categoria.map((doc) => DropdownMenuItem<String>(
                child: Text(doc),
                value: doc,
              ))
          .toList();
          
  }static getDropdownMenuUnidade(){
        return ["Unidade",
			          "Lista",
			          "Fracionado"].map((doc) => DropdownMenuItem<String>(
                child: Text(doc),
                value: doc,
              ))
          .toList();
  }
}