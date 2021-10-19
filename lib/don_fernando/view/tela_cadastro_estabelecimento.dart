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
  
  @override
  void initState() {
    /* rever nessecidade */
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
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
              ],
              initialValue: Estabelecimento().mensagem ?? '',
              onSaved: (valor) => Estabelecimento().mensagem = valor,
              decoration: InputDecoration(labelText: "Mensagem:"),
            ),
            SizedBox(height: 30),
            TextFormField(
              obscureText: true,
              initialValue: Estabelecimento().senha ?? '',
              onSaved: (valor) => Estabelecimento().senha = valor,
              decoration: InputDecoration(labelText: "Senha:"),
            ),
            SizedBox(height: 30),
            TextFormField(
              obscureText: true,
              validator: (valor) {
                if (valor != Estabelecimento().senha) {
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
