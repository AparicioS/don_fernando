import 'package:cloud_firestore/cloud_firestore.dart';

class Estabelecimento {
  static Estabelecimento _instance;
  Estabelecimento._();
  String id;
  String descricao;
  String mensagem;
  String senha;

  resetEstabelecimento() {
    _instance = Estabelecimento._();
  }

  factory Estabelecimento() {
    _instance ??= Estabelecimento._();
    return _instance;
  }
  
  caregaEstabelecimento(String codigo) {
    FirebaseFirestore.instance
        .collection('Estabelecimento')
        .doc(codigo)
        .get()
        .then((value) {
          this.id =codigo;
          Map<String, dynamic> dados = value.data();
          if (dados != null) {
            descricao = dados['descricao'];
            mensagem = dados['mensagem'];
            senha = dados['senha'];
          }
        });
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['descricao'] = descricao;
    map['mensagem'] = mensagem;
    map['senha'] = senha;

    return map;
  }

  Estabelecimento.fromDoc(Map<String, dynamic> map) {
    if (map != null) {
      this.descricao = map['descricao'];
      this.mensagem = map['mensagem'];
      this.senha = map['senha'];
    }
  }

  @override
  String toString() {
    return 'id:' + id + '\ndescricao:' + descricao + '\nmensagem:' + mensagem;
  }
}
