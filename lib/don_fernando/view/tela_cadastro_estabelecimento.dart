import 'package:don_fernando/don_fernando/controller/controller_estabelecimento.dart';
import 'package:don_fernando/don_fernando/model/estabelecimento.dart';
import 'package:don_fernando/don_fernando/view/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:don_fernando/don_fernando/util/string_utils.dart';

class TelaCadastroEstabelecimento extends StatefulWidget {
  @override
  _TelaCadastroEstabelecimentoState createState() => _TelaCadastroEstabelecimentoState();
}

class _TelaCadastroEstabelecimentoState extends State<TelaCadastroEstabelecimento> {
  bool teste = false;
  var nomeCategoria = '';

  @override
  Widget build(BuildContext context) {
    var form = GlobalKey<FormState>();
    return ScaffoldLayout(
      body: Form(
        key: form,
        child: ListView(
          children: [AcaoTopo(
          texto: 'Cadastrar categoria',
          onPressed: (){            
              showDialog(
                context: context,
                builder: (ctx) {
                  return CupertinoAlertDialog(
                    title: Text('Categoria'),
                    content: Card(
                      child: TextField(
                                  onChanged: (value) => nomeCategoria = value,                                  
                                  decoration: InputDecoration(labelText: "Nome:"),
                                ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () { 
                            Navigator.pop(ctx); },
                          child: Text('Voltar')),
                      TextButton(
                        child: Text("Salvar"),
                        onPressed: () async {
                          if(nomeCategoria != ''){
                            if(!StrUtil.contem(Estabelecimento().categoria,nomeCategoria)){
                              Estabelecimento().categoria.add(nomeCategoria.trim());
                              if (form.currentState.validate()) {
                                form.currentState.save();
                                print(Estabelecimento().categoria.toString());
                                var retorno = await ControllerEstabelecimento.cadastrarEstabelecimento(Estabelecimento());              
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (contx) {
                                      return CupertinoAlertDialog(
                                        title: Text('Categoria'),
                                        content: Text(retorno),
                                        actions: [
                                          TextButton(
                                              onPressed: () => Navigator.pop(contx),
                                              child: Text('OK'))
                                        ],
                                      );
                                    });
                              } 
                            }else {
                              showDialog(
                                context: context,
                                builder: (contx) {
                                  return CupertinoAlertDialog(
                                    title: Text('Estabelecimento'),
                                    content: Text('Categoria ja cadastrada'),
                                    actions: [
                                      TextButton(
                                          onPressed: () => Navigator.pop(contx),
                                          child: Text('OK'))
                                    ],
                                  );
                                });
                            }
                          }
                        }
                        )
                    ],
                  );
                }
              );
          },
      ),
            SizedBox(
              height: 60,
              child: Center(
                child: Title(
                    title: 'Dados do Estabelecimeto',
                    color: Cor.titulo(),
                    child: Text(
                      "Dados do Estabelecimeto",
                      style: TextStyle(fontSize: 30),
                    )),
              ),
            ),
            TextFormField(
              readOnly: true,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                FilteringTextInputFormatter.digitsOnly
              ],
              initialValue: Estabelecimento().id ?? '',
              onSaved: (valor) => Estabelecimento().id = valor,
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
              initialValue: Estabelecimento().descricao ?? '',
              onSaved: (valor) => Estabelecimento().descricao = valor,
              decoration: InputDecoration(labelText: "Nome/Identificação:"),
            ),
            SizedBox(height: 30),
            TextFormField(
              initialValue: Estabelecimento().mensagem ?? '',
              onSaved: (valor) => Estabelecimento().mensagem = valor,
              decoration: InputDecoration(labelText: "Mensagem:"),
            ),
            SizedBox(height: 30),
            CheckboxListTile(
                title: Text("Imprimir Nome do Estabelecimento"),
                value: Estabelecimento().configuracao['estabelecimento']??false,
                onChanged: (bool value){
                            setState((){
                              Estabelecimento().configuracao['estabelecimento']=value;
                              teste = value;
                            });
                          },
            ),CheckboxListTile(
                title: Text("Imprimir Categoria do Produto"),
                value: Estabelecimento().configuracao['categoria']??false,
                onChanged: (bool value){
                            setState((){
                              Estabelecimento().configuracao['categoria']=value;
                              teste = value;
                            });
                          },
            ),CheckboxListTile(
                title: Text("Imprimir Descrição do Produto"),
                value: Estabelecimento().configuracao['produto']??false,
                onChanged: (bool value){
                            setState((){
                              Estabelecimento().configuracao['produto']=value;
                              teste = value;
                            });
                          },
            ),CheckboxListTile(
                title: Text("Imprimir Valor do Produto"),
                value: Estabelecimento().configuracao['valor']??false,
                onChanged: (bool value){
                            setState((){
                              Estabelecimento().configuracao['valor']=value;
                              teste = value;
                            });
                          },
            ),CheckboxListTile(
                title: Text("Imprimir Mensagem do Estabelecimento"),
                value: Estabelecimento().configuracao['mensagem']??false,
                onChanged: (bool value){
                            setState((){
                              Estabelecimento().configuracao['mensagem']=value;
                              teste = value;
                            });
                          },
            ),CheckboxListTile(
                title: Text("Imprimir Data "),
                value: Estabelecimento().configuracao['data']??false,
                onChanged: (bool value){
                            setState((){
                              Estabelecimento().configuracao['data']=value;
                              teste = value;
                            });
                          },
            ),
          ],
        ),
      ),
      floatingActionButton: BotaoRodape(
          child: Text("Salvar"),
          onPressed: () async {
            if (form.currentState.validate()) {
              form.currentState.save();
              var retorno = await ControllerEstabelecimento.cadastrarEstabelecimento(Estabelecimento());              
              Navigator.pop(context);
              print(retorno);
              showDialog(
                  context: context,
                  builder: (contx) {
                    return CupertinoAlertDialog(
                      title: Text('Estabelecimento'),
                      content: Text(retorno),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(contx),
                            child: Text('OK'))
                      ],
                    );
                  });
            }
          }),
          
    );
  }
}
