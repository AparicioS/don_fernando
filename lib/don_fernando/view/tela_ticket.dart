import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:don_fernando/don_fernando/controller/controller_estoque.dart';
import 'package:don_fernando/don_fernando/controller/controller_produto.dart';
import 'package:don_fernando/don_fernando/model/estabelecimento.dart';
import 'package:don_fernando/don_fernando/model/produto.dart';
import 'package:don_fernando/don_fernando/view/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaTicket extends StatefulWidget {
  @override
  _TelaTicketState createState() => _TelaTicketState();
}

class _TelaTicketState extends State<TelaTicket> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  bool isConnected=false;
  List<Produto> produtos = [];
  List<Produto> pedido = [];
  List<Produto> produtoTodos = [];
  List categorias = [];  
  String _categoria = "Todas";  
  double total = 0;
  Map<String,int> quantidade = Map();
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
  addQUantidade(String key){
    if(quantidade.keys.contains(key)){
        quantidade[key]++;
    }else{
      quantidade[key] =1;
    }
  }
  getQantidade(String key){
    if(quantidade.keys.contains(key)){
        return quantidade[key];
    }else{
      return 0;
    }
  }
  _criarColunaTableConfirma() {    
	  List <TableRow>colunas = pedido.toSet().map((produto) {
		return TableRow(
		children:[Text(quantidade[produto.descricao].toString()),
              Container( alignment: Alignment.centerLeft,child: Text(produto.descricao)),]
		);
	}).toList();
  colunas.add(TableRow(children:[Text(""),Container( alignment: Alignment.centerLeft,child: Text("")),]));
  colunas.add(TableRow(children:[Text("Total"),Container( alignment: Alignment.centerLeft,child: Text("R\$"+total.toString())),]));
	return colunas;
  }
_criarColunaTable() {    
	  List <TableRow>colunas = pedido.toSet().map((produto) {
		return TableRow(
		children:[Text(produto.descricao),
              Text(quantidade[produto.descricao].toString()),
              Container(child: IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => setState(() {
							                          total -= double.parse(produto.valor);
                                        pedido.remove( produto);
                                        quantidade[produto.descricao]--;
														          })
                                  ),
                        ),
                 ]
		);
	}).toList();
	return colunas;
  }
  @override
  void initState() {
    bluetoothPrint.isConnected.then((value) => isConnected =value);     
    categorias = Estabelecimento().categoria;
    ControllerProduto.buscarProdutos()
    .then((value) => setState(() {
        produtoTodos = value;
        produtos = value;
    }));
    super.initState();
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
          ListTile(
            title: Title(
                color: Cor.titulo(),
                child: Text(
                  'Produtos'
                  ,style: TextStyle(fontSize: Size.sizeTextTitleList),
                )),
            trailing: Text("Quantidade",style: TextStyle(fontSize: Size.sizeTextTitleList)),
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.95,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                return (ListTile(
                  title: Text(produtos[index].descricao.toString(),style: TextStyle(fontSize: Size.sizeTextTitleList)),
                  subtitle:
                      Text("Valor : R\$ "+produtos[index].valor.toString(),style: TextStyle(fontSize: Size.sizeTextSubTitleList)),
                  trailing: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () async => 
                          await ControllerEstoque.validaQuantidade(produtos[index],getQantidade(produtos[index].descricao))
                          .then((value){
                              if(value){
                                setState(() {
                                  pedido.add( produtos[index] );
                                  total+= double.parse(produtos[index].valor);
                                  addQUantidade(produtos[index].descricao);
                                });
                                
                              }else{
                                showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: Text(produtos[index].descricao.toString()),
                                      content: new Text("sem estoque disponivel"),
                                    );
                                  });
                              }
                              })
                         ),
                ));
              },
            ),
          ),
          Divider(),
          Container(
            height: MediaQuery.of(context).size.width * 0.230,
            child: ListView(
              children: [
                Table(
                  children: _criarColunaTable()
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            child: Row(children: [Text("Total R\$"),Text(total.toString()??"00.00")],),
          ), 
        ],
      ),
      floatingActionButton: BotaoRodape(
          onPressed: (){            
              showDialog(
                context: context,
                builder: (ctx) {
                  return CupertinoAlertDialog(
                    title: Text('Produto'),
                    content: Table(
                              children: _criarColunaTableConfirma()
                            ),
                    actions: [
                      TextButton(
                          onPressed: () { Navigator.pop(ctx); },
                          child: Text('Voltar')),
                      TextButton(
                          onPressed: () async { Map<String, dynamic> config = Map();
                              config['width'] = 160; 
                              config['height'] = 190; 
                              config['gap'] = 10; 
                              if(isConnected){
                                   pedido.forEach((element) async { 
                                         await bluetoothPrint.printLabel(config, Ticket.getTicket(element));
                                   });
                                   ControllerEstoque.baixarEstoque(pedido);
                                 Navigator.pop(ctx);
                                 setState(() {
                                     total = 00.00;
                                     pedido.clear();
                                     quantidade.clear();
                                 });
                              }else{
                                showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: Text('Impressora desconactada'),
                                      content: new Text("voce precisa conectar uma impressora "),
                                    );
                                  });

                              }
                          },
                          child: Text('imprimir'))
                    ],
                  );
                }
              );
          },
          child: Text("Finalizar")
      ),
    );
  }
}
