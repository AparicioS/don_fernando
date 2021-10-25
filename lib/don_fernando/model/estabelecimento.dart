import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:don_fernando/don_fernando/controller/controller_produto.dart';
import 'package:don_fernando/don_fernando/model/produto.dart';

class Estabelecimento {
  static Estabelecimento _instance;
  Estabelecimento._();
  String id;
  String descricao;
  String mensagem;
  String senha;
  List<Produto> produtos;  

  resetEstabelecimento() {
    _instance = Estabelecimento._();
  }

  factory Estabelecimento() {
    _instance ??= Estabelecimento._();
    return _instance;
  }
  
  caregaEstabelecimento(String codigo) async {
    await FirebaseFirestore.instance
        .collection('Estabelecimento')
        .doc(codigo)
        .get()
        .then((value) {
          this.id = value.id;
          Map<String, dynamic> dados = value.data();
          if (dados != null) {
            descricao = dados['descricao'];
            mensagem = dados['mensagem'];
            senha = dados['senha'];
          }
        });
    await ControllerProduto.buscarProdutos().then((value) => produtos = value);
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['descricao'] = descricao;
    map['mensagem'] = mensagem;
    map['senha'] = senha;

    return map;
  }

  Estabelecimento.fromDoc(QueryDocumentSnapshot doc) {
    if (doc != null) {
      Map<String, dynamic> map = doc.data();
      this.id = doc.id;
      this.descricao = map['descricao'];
      this.mensagem = map['mensagem'];
      this.senha = map['senha'];
    }
  }
  Estabelecimento.fromMap(Map<String, dynamic> map) {
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
