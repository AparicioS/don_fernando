
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:don_fernando/don_fernando/model/estabelecimento.dart';
import 'package:don_fernando/don_fernando/view/layout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TelaConectaImpressora extends StatefulWidget {
  @override
  _TelaConectaImpressoraState createState() => _TelaConectaImpressoraState();
}

class _TelaConectaImpressoraState extends State<TelaConectaImpressora> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  bool _connected = false;
  BluetoothDevice _device;
  String tips = 'Conectar impressora';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
    super.initState();
  }
  
  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));

    bool isConnected=await bluetoothPrint.isConnected;

    bluetoothPrint.state.listen((state) {
      print('device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'conectado '+ _device.name;
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'conectar impressora';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if(isConnected) {
      setState(() {
        tips = 'conectado '+ _device.name;
        _connected=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
            appBar: AppBar(
              backgroundColor: Cor.cabecario(0.8),
              title: Center(
                child: Text('Don Fernando',
                    style: TextStyle(color: Cor.titulo(), fontSize: 30)),
              ),
            ),
          body: RefreshIndicator(
            onRefresh: () =>bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text(tips,
                    style: TextStyle(color: Cor.titulo(), fontSize: 30)),
                      ),
                    ],
                  ),
                  Divider(),
                  StreamBuilder<List<BluetoothDevice>>(
                    stream: bluetoothPrint.scanResults,
                    initialData: [],
                    builder: (c, snapshot) => Column(
                      children: snapshot.data.map((d) => ListTile(
                        title: Text(d.name??''),
                        subtitle: Text(d.address),
                        onTap: () async {
                          setState(() {
                            _device = d;
                          });
                        },
                        trailing: _device!=null && _device.address == d.address?Icon(
                          Icons.check,
                          color: Colors.green,
                        ):null,
                      )).toList(),
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            OutlinedButton(
                              child: Text('conectar'),
                              onPressed:  _connected?null:() async {
                                if(_device!=null && _device.address !=null){
                                  await bluetoothPrint.connect(_device);
                                }else{
                                  setState(() {
                                    tips = 'selecione a impressora';
                                  });
                                }
                              },
                            ),
                            SizedBox(width: 10.0),
                            OutlinedButton(
                              child: Text('desconectar'),
                              onPressed:  _connected?() async {
                                await bluetoothPrint.disconnect();
                              }:null,
                            ),
                          ],
                        ),
                        OutlinedButton(
                          child: Text('teste de impressão'),
                          onPressed:  _connected?() async {
                            Map<String, dynamic> config = Map();
                            List<LineText> list = [];
                            list.add(LineText(align:LineText.ALIGN_CENTER ,width: 10,height: 10,type: LineText.TYPE_TEXT, x:10, y:10, content: Estabelecimento().descricao+"\n\n"));
                            list.add(LineText(align:LineText.ALIGN_CENTER ,width: 10,height: 10,type: LineText.TYPE_TEXT, x:10, y:10, content: "Don Fernando \n"));
                            list.add(LineText(align:LineText.ALIGN_CENTER ,type: LineText.TYPE_TEXT, x:10, y:10, content: "Teste de Impressao\n"));
                            list.add(LineText(align:LineText.ALIGN_CENTER ,type: LineText.TYPE_TEXT, x:10, y:10, content: _device.name+"\n"));
                            list.add(LineText(align:LineText.ALIGN_CENTER ,type: LineText.TYPE_TEXT, x:10, y:10, content: _device.address+"\n\n"));
                            list.add(LineText(align:LineText.ALIGN_CENTER ,underline: 1,type: LineText.TYPE_TEXT, x:10, y:10, content:  DateFormat("dd/MM/yyyy").format(DateTime.now())));
                            list.add(LineText(type: LineText.TYPE_TEXT, x:10, y:10, content: "\n--------------------------------"));
                            list.add(LineText(type: LineText.TYPE_TEXT, x:10, y:10, content: "\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"));
                            list.add(LineText(type: LineText.TYPE_TEXT, x:10, y:10, content: "\n\n--------------------------------"));
                            await bluetoothPrint.printLabel(config, list);    
                          }:null,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        floatingActionButton: StreamBuilder<bool>(
          stream: bluetoothPrint.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data) {
              return FloatingActionButton(
                child: Icon(Icons.stop),
                onPressed: () => bluetoothPrint.stopScan(),
                backgroundColor: Colors.red,
              );
            } else {
              return FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () => bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
            }
          },
        ),
      ),
    );
  }
}
