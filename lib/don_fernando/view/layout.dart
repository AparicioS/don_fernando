import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:don_fernando/don_fernando/model/estabelecimento.dart';
import 'package:don_fernando/don_fernando/model/produto.dart';
import 'package:don_fernando/don_fernando/util/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Cor {
  static Color texto([double opacity = 1]) => Color.fromRGBO(0, 0, 0, opacity);
  static Color erro([double opacity = 1]) =>
      Color.fromRGBO(178, 34, 34, opacity);
  static Color sucesso([double opacity = 1]) =>
      Color.fromRGBO(0, 0, 255, opacity);
  static Color titulo([double opacity = 1]) =>
      Color.fromRGBO(0, 0, 0, opacity);
  static Color cabecario([double opacity = 1]) =>
      Color.fromRGBO(240,230,140, opacity);
  static Color backgrud([double opacity = 1]) =>
      Color.fromRGBO(231, 244, 192, opacity);
  static Color botaoverde([double opacity = 1]) =>
      Color.fromRGBO(39, 174, 96, opacity);
  static Color botaoAzul([double opacity = 0.9]) =>
      Color.fromRGBO(17, 116, 255, opacity);
  static Color textoAzul([double opacity = 1]) =>
      Color.fromRGBO(0, 0, 250, opacity);
}
class Size{
  static double sizeTextTitleList = 30;
  static double sizeTextSubTitleList = 20;
  static double sizeTextLeadingList = 30;
  static double sizeTextTrailingList = 30;
}

class ScaffoldLayout extends Scaffold {
  ScaffoldLayout({Widget body, drawer,acoes,botoes, floatingActionButton})
      : super(
            appBar: AppBar(
              backgroundColor: Cor.cabecario(0.8),
              title: Center(
                child: Text('Don Fernando',
                    style: TextStyle(color: Cor.titulo(), fontSize: 30)),
              ),
              actions: acoes,
              bottom: botoes,
            ),
            drawer:drawer,
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('imagens/fundoHome.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: EdgeInsets.all(5),
                child: body),
            floatingActionButton: floatingActionButton);
}

class BotaoRodape extends TextButton {
  BotaoRodape({onLongPress, onPressed, child})
      : super(
            style: TextButton.styleFrom(primary: Colors.white),
            onLongPress: onLongPress,
            onPressed: onPressed,
            child: Container(
                width: 120,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Cor.botaoAzul(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    )),
                child: child));
}

class AcaoTopo extends Container {
  AcaoTopo({onPressed, icone, texto})
      : super(
          height: 30,
          child: Align(
            alignment: Alignment.bottomRight,
            child: TextButton.icon(
                style: TextButton.styleFrom(primary: Cor.botaoAzul()),
                label: Text(texto,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Cor.botaoAzul())),
                icon: Icon(icone),
                onPressed: onPressed),
          ),
        );
}
class Ticket{
  static List<LineText> getTicket(Produto produto){
    List<LineText> list = [];
    list.add(LineText(type: LineText.TYPE_TEXT, x:10, y:10, content: "xxxxxxxxx Don Fernando xxxxxxxxx\n\n"));
    if(Estabelecimento().configuracao['estabelecimento']) list.add(LineText(align:LineText.ALIGN_CENTER ,width: 10,height: 10,type: LineText.TYPE_TEXT, x:10, y:10, content: StrUtil.removerAcentos( Estabelecimento().descricao)+"\n\n"));
    if(Estabelecimento().configuracao['categoria']) list.add(LineText(align:LineText.ALIGN_CENTER ,width: 10,height: 10,type: LineText.TYPE_TEXT, x:10, y:10, content: StrUtil.removerAcentos(produto.categoria)+"\n"));
    if(Estabelecimento().configuracao['produto']) list.add(LineText(align:LineText.ALIGN_CENTER ,width: 10,height: 10,type: LineText.TYPE_TEXT, x:10, y:10, content: StrUtil.removerAcentos(produto.descricao)+"\n\n"));
    if(Estabelecimento().configuracao['valor']) list.add(LineText(align:LineText.ALIGN_CENTER ,width: 10,height: 10,type: LineText.TYPE_TEXT, x:10, y:10, content: "R\$"+produto.valor+"\n\n"));
    if(Estabelecimento().configuracao['mensagem']) list.add(LineText(align:LineText.ALIGN_CENTER ,type: LineText.TYPE_TEXT, x:10, y:10, content: StrUtil.removerAcentos(Estabelecimento().mensagem)+"\n"));
    if(Estabelecimento().configuracao['data']) list.add(LineText(align:LineText.ALIGN_CENTER ,underline: 1,type: LineText.TYPE_TEXT, x:10, y:10, content:  DateFormat("dd/MM/yyyy").format(DateTime.now())));
    list.add(LineText(type: LineText.TYPE_TEXT, x:10, y:10, content: "\n________________________________\n"));
    list.add(LineText(type: LineText.TYPE_TEXT, x:10, y:10, content: "--------------------------------\n\n"));
    return list;           
  }
}
