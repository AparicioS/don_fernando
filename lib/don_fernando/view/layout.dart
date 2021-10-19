import 'package:flutter/material.dart';

class Cor {
  static Color texto([double opacity = 1]) => Color.fromRGBO(0, 0, 0, opacity);
  static Color erro([double opacity = 1]) =>
      Color.fromRGBO(178, 34, 34, opacity);
  static Color sucesso([double opacity = 1]) =>
      Color.fromRGBO(0, 0, 255, opacity);
  static Color titulo([double opacity = 1]) =>
      Color.fromRGBO(0, 0, 0, opacity);
  static Color cabecario([double opacity = 1]) =>
      Color.fromRGBO(255, 140, 0, opacity);
  static Color backgrud([double opacity = 1]) =>
      Color.fromRGBO(231, 244, 192, opacity);
  static Color botaoverde([double opacity = 1]) =>
      Color.fromRGBO(39, 174, 96, opacity);
  static Color botaoAzul([double opacity = 0.9]) =>
      Color.fromRGBO(17, 116, 255, opacity);
  static Color textoAzul([double opacity = 1]) =>
      Color.fromRGBO(0, 0, 250, opacity);
}

class ScaffoldLayout extends Scaffold {
  ScaffoldLayout({Widget body, acoes, floatingActionButton})
      : super(
            appBar: AppBar(
              backgroundColor: Cor.cabecario(0.8),
              title: Center(
                child: Text('Kaj Pub',
                    style: TextStyle(color: Cor.titulo(), fontSize: 30)),
              ),
              actions: acoes,
            ),
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
