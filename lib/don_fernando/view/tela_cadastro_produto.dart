
import 'package:don_fernando/don_fernando/view/layout.dart';
import 'package:don_fernando/don_fernando/view/tela_pricipal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaCadastroProduto extends StatefulWidget {
  @override
  _TelaCadastroProdutoState createState() => _TelaCadastroProdutoState();
}

class _TelaCadastroProdutoState extends State<TelaCadastroProduto> {
  List<DropdownMenuItem> listaRegiao;
  List<DropdownMenuItem> listaAlimentacao;
  List<DropdownMenuItem> listaFinalidade;
  //Produto Produto;
  String msg;

  @override
  void initState() {
   /* rebanho = Rebanho.novo();
    FirebaseFirestore.instance
        .collection('Rebanho')
        .doc(Usuario().id)
        .get()
        .then((value) {
      setState(() {
        if (value.id == Usuario().id) {
          rebanho = Rebanho.fromDoc(value.data());
          msg = 'ao alterar registro.';
        } else {
          msg = 'ao incluir registro.';
        }
      });
    });

    FirebaseFirestore.instance
        .collection('regiao')
        .snapshots()
        .listen((colecao) {
      List<DropdownMenuItem> lista = colecao.docs
          .map((doc) => DropdownMenuItem<String>(
                child: Text(doc.id),
                value: doc.id,
              ))
          .toList();
      setState(() {
        listaRegiao = lista;
      });
    });

    FirebaseFirestore.instance
        .collection('alimentacao')
        .snapshots()
        .listen((colecao) {
      List<DropdownMenuItem> lista = colecao.docs
          .map((doc) => DropdownMenuItem<String>(
                child: Text(doc.id),
                value: doc.id,
              ))
          .toList();
      setState(() {
        listaAlimentacao = lista;
      });
    });

    FirebaseFirestore.instance
        .collection('finalidade')
        .snapshots()
        .listen((colecao) {
      List<DropdownMenuItem> lista = colecao.docs
          .map((doc) => DropdownMenuItem<String>(
                child: Text(doc.id),
                value: doc.id,
              ))
          .toList();
      setState(() {
        listaFinalidade = lista;
      });
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
      body: ListView(
        children: [
          Center(
              child: Text(
            "Dados do Produto",
            style: TextStyle(fontSize: 30),
          )),
          SizedBox(height: 30),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Codigo:",
                hintText: 'informe o codigo para o Produto'),
          ),
          SizedBox(height: 30),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Descrição:",
                hintText: 'informe a Descrição para o Produto'),
          ),
          SizedBox(height: 30),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Valor:",
                hintText: 'informe o valor do Produto'),
          ),
        ],
      ),
      floatingActionButton: BotaoRodape(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => TelaPricipal()));
          },
          child: Text("Salvar")),
    );
  }
}
