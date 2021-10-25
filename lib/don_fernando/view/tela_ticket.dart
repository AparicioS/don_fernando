import 'package:don_fernando/don_fernando/controller/controller_estoque.dart';
import 'package:don_fernando/don_fernando/model/estoque.dart';
import 'package:don_fernando/don_fernando/view/layout.dart';
import 'package:don_fernando/don_fernando/view/tela_cadastro_estoque_produto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaTicket extends StatefulWidget {
  @override
  _TelaTicketState createState() => _TelaTicketState();
}

class _TelaTicketState extends State<TelaTicket> {
  List<Estoque> estoques = [];
  List<Estoque> estoquesTodos = [];
  List<TextButton> listaCategoria;
  final List<String> _categorias = [
    'Litro',
    'Dose',
    'Lata',
    'Combo'
  ];

  @override
  void initState() {    
    
    ControllerEstoque.buscarEstoques()
    .then((value) => setState(() {
        estoques = value;
        estoquesTodos = value;
    }));
    
    super.initState();
    
    listaCategoria = _categorias.map((doc) => 
                     TextButton( onPressed: ()=>setState(() {
                       estoques = estoquesTodos.where((element) => element.produto.categoria == doc ).toList();
                       }),
                    child: Text(doc))).toList();
  }


  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
      acoes: listaCategoria,
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
