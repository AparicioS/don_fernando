
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:don_fernando/don_fernando/controller/controller_estoque.dart';
import 'package:don_fernando/don_fernando/controller/controller_produto.dart';
import 'package:don_fernando/don_fernando/model/estabelecimento.dart';
import 'package:don_fernando/don_fernando/model/estoque.dart';
import 'package:don_fernando/don_fernando/view/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaCadastroEstoqueProduto extends StatefulWidget {
  @override
  _TelaCadastroEstoqueProdutoState createState() => _TelaCadastroEstoqueProdutoState();
}

class _TelaCadastroEstoqueProdutoState extends State<TelaCadastroEstoqueProduto> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  Estoque estoque;
  List<DropdownMenuItem> listaProduto;

  @override
  void didChangeDependencies() {
    estoque = ModalRoute.of(context).settings.arguments ?? Estoque.novo();
    super.didChangeDependencies();
  }
  @override
  void initState() {
    estoque ??= Estoque.novo();
    carregarEstoque();
    super.initState();
  }
  carregarEstoque() {    
    listaProduto = Estabelecimento().produtos
                  .where((element) => element.unidade=='Unidade')
                  .map((doc) => DropdownMenuItem<String>(
                child: Text(doc.descricao),
                value: doc.id,
              ))
          .toList();
  }
  @override
  Widget build(BuildContext context) {
    var form = GlobalKey<FormState>();
    return ScaffoldLayout(
      body: Form(
        key: form,
        child: ListView(
          children: [
          AcaoTopo(
              texto: 'imprimir',
              onPressed: () async {
                            Map<String, dynamic> config = Map();
                            config['width'] = 160; 
                            config['height'] = 190; 
                            config['gap'] = 10; 

                            await bluetoothPrint.printLabel(config, Ticket.getTicket(estoque.produto));}),
            SizedBox(
              height: 60,
              child: Center(
                child: Title(
                    title: 'Cadastro Produto Estoque',
                    color: Cor.titulo(),
                    child: Text(
                      "Cadastro Produto Estoque",
                      style: TextStyle(fontSize: 30),
                    )),
              ),
            ),
            DropdownButtonFormField<String>(
              value: estoque.produto.id,
              onSaved: (data) => estoque.produto.id = data,
              decoration: InputDecoration(
                  labelText: "Produto:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: listaProduto,
              onChanged: estoque.produto.descricao == null ?(value) => print("selecionado: $value"): null,
            ),
            SizedBox(height: 30), 
            TextFormField(
              keyboardType: TextInputType.number,
              // readOnly: true,
              initialValue: estoque.quantidade?.toString(),
              onSaved: (valor) => estoque.quantidade = int.parse(valor),
              decoration: InputDecoration(labelText: "Quantidade:"),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: BotaoRodape(
          child: Text("Salvar"),
          onPressed: () async {
            if (form.currentState.validate()) {
              form.currentState.save();
              var retorno = await ControllerEstoque.cadastrarEstoque(estoque);
              setState(() {                
                ControllerProduto.buscarProdutos().then((value) => Estabelecimento().produtos = value);
              });
              print(retorno);
              showDialog(
                context: context,
                builder: (ctx) {
                  return CupertinoAlertDialog(
                    title: Text('Produto Estoque'),
                    content: Text(retorno + 'ao incluir o registro...'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            form.currentState.reset();
                            Navigator.pop(ctx);
                          },
                          child: Text('Novo cadastro')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(ctx);
                          },
                          child: Text('OK'))
                    ],
                  );
                });
            }
          }),
          
    );
  }
}
