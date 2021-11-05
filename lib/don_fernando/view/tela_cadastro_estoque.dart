import 'package:don_fernando/don_fernando/controller/controller_estoque.dart';
import 'package:don_fernando/don_fernando/model/estoque.dart';
import 'package:don_fernando/don_fernando/view/layout.dart';
import 'package:don_fernando/don_fernando/view/tela_cadastro_estoque_produto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaCadastroEstuque extends StatefulWidget {
  @override
  _TelaCadastroEstuqueState createState() => _TelaCadastroEstuqueState();
}

class _TelaCadastroEstuqueState extends State<TelaCadastroEstuque> {
  List<Estoque> estoques = [];

  @override
  void initState() {    
    
    ControllerEstoque.buscarEstoques()
    .then((value) => setState(() {
        estoques = value;
    }));
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(      
      body: ListView(
        children: [
          Center(
              child: Text(
            "Estoque",
            style: TextStyle(fontSize: Size.sizeTextTitleList),
          )),
          Column(
            children: [
              ListTile(
                title: Title(
                    color: Cor.titulo(),
                    child: Text(
                      'Produtos'
                      ,style: TextStyle(fontSize: Size.sizeTextTitleList),
                    )),
                trailing: Text("Quantidade",style: TextStyle(fontSize: Size.sizeTextTitleList)),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.width * 1.2,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: estoques.length,
              itemBuilder: (context, index) {
                return (ListTile(
                  leading: Text(estoques[index].produto.id.toString(),style: TextStyle(fontSize: Size.sizeTextLeadingList)),
                  title: Text(estoques[index].produto.descricao.toString(),style: TextStyle(fontSize: Size.sizeTextTitleList)),
                  subtitle:
                      Text("Valor : R\$ "+estoques[index].produto.valor.toString(),style: TextStyle(fontSize: Size.sizeTextSubTitleList)),
                  trailing: Text(estoques[index].quantidade.toString(),style: TextStyle(fontSize: Size.sizeTextTrailingList)),
                  onTap: () {
                    debugPrint(estoques[index].produto.descricao);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => TelaCadastroEstoqueProduto(),
                        settings: RouteSettings(arguments: estoques[index])));
                  },
                ));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: BotaoRodape(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => TelaCadastroEstoqueProduto()));
          },
          child: Text("Novo")),
    );
  }
}
