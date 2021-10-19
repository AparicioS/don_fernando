
import 'dart:math';
import 'package:don_fernando/don_fernando/view/layout.dart';
import 'package:don_fernando/don_fernando/view/tela_cadastro_produto.dart';
import 'package:don_fernando/don_fernando/view/tela_pricipal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaCadastroEstuque extends StatefulWidget {
  @override
  _TelaCadastroEstuqueState createState() => _TelaCadastroEstuqueState();
}

class _TelaCadastroEstuqueState extends State<TelaCadastroEstuque> {
  var random = new Random();
  List<String> produtos;
  String msg;

  @override
  void initState() {
    produtos = List<String>.generate(
        random.nextInt(10), (i) => "Produto" + (i + 1).toString());
    super.initState();
  }
  Future<void> _carregaLista() async {
    setState(() {
      produtos = List<String>.generate(
          random.nextInt(50), (i) => "Produto" + (i + 1).toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
      
      body: RefreshIndicator(
        onRefresh: _carregaLista,
        child: ListView.builder(
          itemCount: produtos.length,
          itemBuilder: (context, index) {
            return (ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text(produtos[index]),
              subtitle:
                  Text(produtos[index] + "/" + produtos.length.toString()),
              trailing: Icon(Icons.ad_units),
              onTap: () {
                debugPrint(produtos[index]);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => TelaCadastroProduto(),
                    settings: RouteSettings(arguments: produtos[index])));
              },
            ));
          },
        ),
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
