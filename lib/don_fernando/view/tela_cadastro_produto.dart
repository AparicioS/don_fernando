
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
  final List<String> _categorias = [
    'Litro',
    'Dose',
    'Lata',
    'Combo'
  ];
  List<DropdownMenuItem> listaCategoria;

  @override
  void initState() {
    produto = Produto.novo();
   listaCategoria = _categorias.map((doc) => DropdownMenuItem<String>(
                child: Text(doc),
                value: doc,
              ))
          .toList();
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
              onSaved: (data) => produto.categoria = data,
              decoration: InputDecoration(
                  labelText: "Categoria:",
                  contentPadding: EdgeInsets.all(10),
                  counterStyle: TextStyle(color: Colors.red)),
              items: listaCategoria,
              onChanged: (value) => print("selecionado: $value"),
            ),
            SizedBox(height: 30),
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
              onSaved: (valor) => produto.id = valor,
              validator: (valor) {
                if (valor.isEmpty) {
                  return 'campo obrigatorio';
                }
                return null;
              },
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Codigo:"),
            ),
            SizedBox(height: 30),
            TextFormField(
              onSaved: (valor) => produto.descricao = valor,
              decoration: InputDecoration(labelText: "Nome/Identificação:"),
            ),
            SizedBox(height: 30),
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
              onSaved: (valor) => produto.valor= valor,
              decoration: InputDecoration(labelText: "Valor:"),
            ),
            SizedBox(height: 30),
            TextFormField(
              onSaved: (valor) => produto.medida = valor,
              decoration: InputDecoration(labelText: "Medida:"),
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
