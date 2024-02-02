import 'package:don_fernando/don_fernando/model/estabelecimento.dart';
import 'package:don_fernando/don_fernando/model/produto.dart';
import 'package:don_fernando/don_fernando/view/layout.dart';
import 'package:don_fernando/don_fernando/view/tela_cadastro_produto.dart';
import 'package:flutter/material.dart';

class TelaConsultaProduto extends StatefulWidget {
  @override
  _TelaConsultaProdutoState createState() => _TelaConsultaProdutoState();
}

class _TelaConsultaProdutoState extends State<TelaConsultaProduto> {
  List<Produto> produtos = [];
  List<Produto> produtoTodos = [];
  List categorias = [];  
  String _categoria = "Todas";  

  @override
  void initState() { 
    carregarProdutos();   
    categorias = Estabelecimento().categoria;
    super.initState();
  }
carregarProdutos() {
  setState(() {
    produtos = Estabelecimento().produtos;
    produtoTodos = produtos;
    
  });
}    
carregarCategorias() {    
    List lista = categorias.where((element) => element != _categoria).toList();
    lista.add("Todas"); 
    return ListView.builder(
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          return (ListTile(
            title: Text(lista[index],style: TextStyle(fontSize: Size.sizeTextTitleList)),
            onTap: () {
              setState(() {
                _categoria = lista[index];
                  produtos = _categoria == "Todas"?produtoTodos:produtoTodos.where((element) => element.categoria == lista[index] ).toList();                
              });
              Navigator.pop(context);

            },
          ));
        });
  }
  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout( 
      drawer: Drawer(
        child: carregarCategorias(),
      ),     
      body: ListView(
        children: [Align(
            alignment: Alignment.bottomRight,
            child: Text(_categoria, 
                style: TextStyle(color: Cor.botaoAzul()),),
          ),
          Center(
              child: Text(
            "Produtos",
            style: TextStyle(fontSize: Size.sizeTextTitleList),
          )),
          ListTile(
            title: Title(
                color: Cor.titulo(),
                child: Text(
                  'Produto'
                  ,style: TextStyle(fontSize: Size.sizeTextTitleList),
                )),
            trailing: Text("Categoria",style: TextStyle(fontSize: Size.sizeTextTitleList)),
          ),
          Container(
            height: MediaQuery.of(context).size.width * 1.2,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                return (ListTile(
                  leading: Text(produtos[index].id.toString(),style: TextStyle(fontSize: Size.sizeTextLeadingList)),
                  title: Text(produtos[index].descricao.toString(),style: TextStyle(fontSize: Size.sizeTextTitleList)),
                  subtitle:
                      Text("Valor : R\$ "+produtos[index].valor.toString(),style: TextStyle(fontSize: Size.sizeTextSubTitleList)),
                  trailing: Text(produtos[index].categoria?.toString(),style: TextStyle(fontSize: Size.sizeTextTrailingList)),
                  onTap: () {
                    debugPrint(produtos[index].descricao);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => TelaCadastroProduto(),
                        settings: RouteSettings(arguments: produtos[index])));
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
                MaterialPageRoute(builder: (_) => TelaCadastroProduto())).then((value) => carregarProdutos());
          },
          child: Text("Novo")),
    );
  }
}
