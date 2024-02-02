import 'package:don_fernando/don_fernando/model/estabelecimento.dart';
import 'package:don_fernando/don_fernando/view/layout.dart';
import 'package:don_fernando/don_fernando/view/tela_cadastro_estabelecimento.dart';
import 'package:don_fernando/don_fernando/view/tela_cadastro_estoque.dart';
import 'package:don_fernando/don_fernando/view/tela_conecta_impressora.dart';
import 'package:don_fernando/don_fernando/view/tela_consulta_produto.dart';
import 'package:don_fernando/don_fernando/view/tela_ticket.dart';
import 'package:flutter/material.dart';

class TelaPricipal extends StatefulWidget {
  @override
  _TelaPricipalState createState() => _TelaPricipalState();
}

class _TelaPricipalState extends State<TelaPricipal> {
    String _valorParametro = "1";

  @override
  void initState() {
    super.initState();
    //_mostrarDialogoInput();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Codigo do estabelecimento'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                _valorParametro = value;
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Estabelecimento().caregaEstabelecimento(_valorParametro);
                Navigator.of(context).pop();
                // Aqui você pode carregar os dados usando o valor do parâmetro
                // _valorParametro
              },
            ),
          ],
        );
      },
    );
    });
  }
  @override
  Widget build(BuildContext context) {
    Estabelecimento().caregaEstabelecimento(_valorParametro);
    final sizewidth = MediaQuery.of(context).size.width;
    final sizeheight = (MediaQuery.of(context).size.height -
        (kToolbarHeight + MediaQuery.of(context).padding.top));
    final double _imagemWidthSize = sizewidth * 0.5;
    final double _imagemHeightSize = sizeheight * 0.20;
    final double _fonteSize = 20;
    return ScaffoldLayout(
      body: Column(
        children: [
          AcaoTopo(
              icone: Icons.print,
              texto: 'impressora',
              onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => TelaConectaImpressora()))}),
            Container(
              padding: EdgeInsets.only(left: 15),
              alignment: Alignment.topLeft,
              child: Title(
                  color: Cor.titulo(),
                  child: Text(Estabelecimento().descricao ??"",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          Container(
            child: Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(primary: Cor.texto()),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => TelaCadastroEstabelecimento()));
                      },
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'imagens/estabelecimento.png',
                                  width: _imagemWidthSize,
                                  height: _imagemHeightSize,
                                ),
                                Text('Estabelecimento',
                                    style: TextStyle(fontSize: _fonteSize))
                              ]))),
                  TextButton(
                      style: TextButton.styleFrom(primary: Cor.texto()),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => TelaConsultaProduto()));
                      },
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'imagens/produtos.png',
                                  width: _imagemWidthSize,
                                  height: _imagemHeightSize,
                                ),
                                Text('Produto',
                                    style: TextStyle(fontSize: _fonteSize))
                              ]))),
                  TextButton(
                      style: TextButton.styleFrom(primary: Cor.texto()),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => TelaCadastroEstuque()));
                      },
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'imagens/cadastro.png',
                                  width: _imagemWidthSize,
                                  height: _imagemHeightSize,
                                ),
                                Text('Estoque',
                                    style: TextStyle(fontSize: _fonteSize))
                              ]))),
                  TextButton(
                      style: TextButton.styleFrom(primary: Cor.texto()),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => TelaTicket()));
                      },
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'imagens/ticket.png',
                                  width: _imagemWidthSize,
                                  height: _imagemHeightSize,
                                ),
                                Text('Ticket',
                                    style: TextStyle(fontSize: _fonteSize))
                              ]))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
