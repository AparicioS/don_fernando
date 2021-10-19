
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:don_fernando/don_fernando/controller/controller_estabelecimento.dart';
import 'package:don_fernando/don_fernando/model/estabelecimento.dart';
import 'package:don_fernando/don_fernando/view/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TelaCadastroEstabelecimento extends StatefulWidget {
  @override
  _TelaCadastroEstabelecimentoState createState() => _TelaCadastroEstabelecimentoState();
}

class _TelaCadastroEstabelecimentoState extends State<TelaCadastroEstabelecimento> {
  Estabelecimento estabelecimento;
  String msg;

  @override
  void initState() {
    estabelecimento = Estabelecimento.novo();
    estabelecimento.id = '123';
    FirebaseFirestore.instance
        .collection('Estabelecimento')
        .doc(estabelecimento.id)
        .get()
        .then((value) {
      setState(() {
        if (value.id == estabelecimento.id) {
          estabelecimento = Estabelecimento.fromDoc(value.data()); 
          estabelecimento.id = value.id ;        
          print(estabelecimento.id);
          msg = 'ao alterar registro.';
        } else {
          print('ao incluir registro.');
          print(estabelecimento.id);
          msg = 'ao incluir registro.';
        }
      });
    });
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
              initialValue: estabelecimento.id ?? '',
              onSaved: (valor) => estabelecimento.id = valor,
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
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
              ],
              initialValue: estabelecimento.descricao ?? '',
              onSaved: (valor) => estabelecimento.descricao = valor,
              decoration: InputDecoration(labelText: "Nome/Identificação:"),
            ),
            SizedBox(height: 30),
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
              ],
              initialValue: estabelecimento.mensagem ?? '',
              onSaved: (valor) => estabelecimento.mensagem = valor,
              decoration: InputDecoration(labelText: "Mensagem:"),
            ),
            SizedBox(height: 30),
            TextFormField(
              obscureText: true,
              initialValue: estabelecimento.senha ?? '',
              onSaved: (valor) => estabelecimento.senha = valor,
              decoration: InputDecoration(labelText: "Senha:"),
            ),
            SizedBox(height: 30),
            TextFormField(
              obscureText: true,
              validator: (valor) {
                if (valor != estabelecimento.senha) {
                  return 'senha não confere';
                }
                return null;
              },
              decoration: InputDecoration(labelText: "Confirma Senha:"),
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
              var retorno = await ControllerEstabelecimento.cadastrarEstabelecimento(estabelecimento);              
              Navigator.pop(context);
              print(retorno);
              showDialog(
                  context: context,
                  builder: (contx) {
                    return CupertinoAlertDialog(
                      title: Text('Estabelecimento'),
                      content: Text(retorno + msg),
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
