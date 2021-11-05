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
  List categoria;
  List<Produto> produtos;
  Map <String,bool>configuracao = Map();  

  resetEstabelecimento() {
    _instance = Estabelecimento._();
  }

  factory Estabelecimento() {
    _instance ??= Estabelecimento._();
    return _instance;
  }
  
  caregaEstabelecimento(String codigo) async {
    configuracao['estabelecimento'] = true;
    configuracao['categoria'] =true;
    configuracao['produto'] =true;
    configuracao['valor'] =false;
    configuracao['mensagem'] =false;
    configuracao['data'] =true;
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
            categoria = dados['categoria'];
          }
        });
    await ControllerProduto.buscarProdutos().then((value) => produtos = value);
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['descricao'] = descricao;
    map['mensagem'] = mensagem;
    map['senha'] = senha;
    map['categoria'] = categoria;

    return map;
  }

  Estabelecimento.fromDoc(QueryDocumentSnapshot doc) {
    if (doc != null) {
      Map<String, dynamic> map = doc.data();
      this.id = doc.id;
      this.descricao = map['descricao'];
      this.mensagem = map['mensagem'];
      this.senha = map['senha'];
      this.categoria = map['categoria'];
    }
  }
  Estabelecimento.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      this.descricao = map['descricao'];
      this.mensagem = map['mensagem'];
      this.senha = map['senha'];
      this.categoria = map['categoria'];
    }
  }

  @override
  String toString() {
    return 'id:' + id + '\ndescricao:' + descricao + '\nmensagem:' + mensagem;
  }
}
