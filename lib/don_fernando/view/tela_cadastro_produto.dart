
import 'package:don_fernando/don_fernando/controller/controller_produto.dart';
import 'package:don_fernando/don_fernando/model/produto.dart';
import 'package:don_fernando/don_fernando/view/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TelaCadastroProduto extends StatefulWidget {
  @override
  _TelaCadastroProdutoState createState() => _TelaCadastroProdutoState();
}

class _TelaCadastroProdutoState extends State<TelaCadastroProduto> {
  Produto produto;


  @override
  void didChangeDependencies() {
    produto = ModalRoute.of(context).settings.arguments ?? Produto.novo();
    super.didChangeDependencies();
  }
  @override
  void initState() {
    produto = Produto.novo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var form = GlobalKey<FormState>();
    return ScaffoldLayout(
      body: Form(
        key: form,
        child: ListView(
          children: [
            SizedBox(
              height: 60,
              child: Center(
                child: Title(
                    title: 'Dados do Produto',
                    color: Cor.titulo(),
                    child: Text(
                      "Dados do Produto",
                      style: TextStyle(fontSize: 30),
                    )),
              ),
            ),
            DropdownButtonFormField<String>(
              value: produto.categoria,
              onSaved: (data) => produto.categoria = data,
              validator: (valor) {
                if (valor.isEmpty) {
                  return 'campo obrigatorio';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Categoria:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: Produto.getDropdownMenuCategorias(),
              onChanged: (value) => print("selecionado: $value"),
            ),
            SizedBox(height: 30),
            TextFormField(
              initialValue: produto.descricao?.toString(),
              onSaved: (valor) => produto.descricao = valor,
              validator: (valor) {
                if (valor.isEmpty) {
                  return 'campo obrigatorio';
                }
                return null;
              },
              decoration: InputDecoration(labelText: "Nome/Identificação:"),
            ),
            SizedBox(height: 30),
            TextFormField(              
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(new RegExp('[0-9.]'))
              ],
              initialValue: produto.valor?.toString(),
              onSaved: (valor) => produto.valor= valor,
              validator: (valor) {
                if (valor.isEmpty) {
                  return 'campo obrigatorio';
                }
                return null;
              },
              decoration: InputDecoration(labelText: "Valor:"),
            ),
            SizedBox(height: 30),            
            DropdownButtonFormField<String>(
              value: produto.unidade,
              onSaved: (data) => produto.unidade = data,
              validator: (valor) {
                if (valor.isEmpty) {
                  return 'campo obrigatorio';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Unidade:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: Produto.getDropdownMenuUnidade(),
              onChanged: (value) => print("selecionado: $value"),
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
              var retorno = await ControllerProduto.cadastrarProduto(produto);
              print(retorno);
              showDialog(
                context: context,
                builder: (ctx) {
                  return CupertinoAlertDialog(
                    title: Text('Produto'),
                    content: Text(retorno + 'ao incluir o registro...'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            form.currentState.reset();
                            produto = Produto.novo();
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
