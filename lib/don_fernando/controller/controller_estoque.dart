import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:don_fernando/don_fernando/controller/controller_produto.dart';
import 'package:don_fernando/don_fernando/model/estabelecimento.dart';
import 'package:don_fernando/don_fernando/model/estoque.dart';
import 'package:don_fernando/don_fernando/model/produto.dart';

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
  static buscaProdutoEstoque(String codigo) async {
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
  static Future quantEstoque(String codigo) async {
    int estoque = 0;
    await FirebaseFirestore.instance
          .collection('Estabelecimento')
          .doc(Estabelecimento().id)
          .collection('Estoque')
          .doc(codigo)
          .get().then((value){
            Map<String, dynamic> dados = value.data();
            if (dados != null) {
              estoque =  dados['quantidade'];
            }
        });
        return estoque;
  }

  static Future<bool> validaQuantidade(Produto prod , quant) async {
    switch (prod.unidade) {
      case 'Unidade':
          bool retorno = true;
          await quantEstoque(prod.id).then((value)=> retorno = (value-quant >0));
          return retorno;
        break;
      case 'Lista':
          bool retorno = true;
          await quantEstoque(prod.composicao.keys.first).then((value)=> retorno = (value-quant >0));
          return retorno;    
        break;
      case 'Fracionado':
      return true;        
        break;
      default:
        return true;
    }
  }

  static baixarEstoque( List<Produto> pedido){
    pedido.forEach((element) async {
      switch (element.unidade) {
        case 'Unidade': quantEstoque(element.id).then((qtd){          
          Estoque estoque = Estoque.novo();
          estoque.setProduto(element);
          estoque.quantidade = qtd-1;
          cadastrarEstoque(estoque);
        });       
          break;
        case 'Lista': element.composicao.forEach((key, value) {
                            quantEstoque(key).then((qtd){          
                            Estoque estoque = Estoque.novo();
                            estoque.produto.id = key;
                            estoque.quantidade = qtd-value;
                            cadastrarEstoque(estoque);
                          });          
                   });       
          break;
        case 'Fracionado':          
          break;
        default:        
          break;
      }
          });
  }
}