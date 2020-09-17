import 'package:flutter/material.dart';
import 'package:barcode_scanner/scan.dart';
import 'package:barcode_scanner/configuracion.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatelessWidget {
  testCard(BuildContext context) {
    return InkWell(
      child: Container(
          width: 200,
          child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.scanner, size: 50, color: Colors.amber),
                    title: Text('Escanear codigo barras',
                        style: TextStyle(color: Colors.white)),
                    subtitle:
                        Text('Scan', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ))),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScanScreen()),
        );
      },
    );
  }

  cardConfiguracion(BuildContext context) {
    return InkWell(
      child: Container(
          width: 200,
          child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(
                      Icons.settings,
                      size: 50,
                      color: Colors.amberAccent,
                    ),
                    title: Text('Configurar Ip',
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text('ip', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ))),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConfiguracionScreen()),
        );
      },
    );
  }

  // var cardConfiguracion = Container(
  //     width: 200,
  //     child: Card(
  //       color: Colors.pink,
  //       shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  //       elevation: 10,
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           const ListTile(
  //             leading: Icon(Icons.settings, size: 50),
  //             title: Text('Configurar ip'),
  //             subtitle: Text('IP'),
  //           ),
  //         ],
  //       ),
  //     ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Escaner Codigo Barras'),
        backgroundColor: Colors.black,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: testCard(context)),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: cardConfiguracion(context)),
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          //   child: RaisedButton(
          //       color: Colors.black,
          //       textColor: Colors.white,
          //       splashColor: Colors.blueGrey,
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => ConfiguracionScreen()),
          //         );
          //       },
          //       child: const Text('Configurar IP >')),
          // ),
        ],
      )),
    );
  }
}
