import 'dart:async';
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:udp/udp.dart';
import 'package:soundpool/soundpool.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";
  var sender;
  //var receiver;
  var pool;

  @override
  initState(){
    super.initState();
    this.startServer();
 
  }

  @override
  dispose() {
    super.dispose();
    this.stopServer();
  }

  stopServer() async{
        print("Back To old Screen");
    String scanDown = "scanner_down";
    await this.sender.send(scanDown.codeUnits, Endpoint.broadcast(port: Port(9000)));
    //this.receiver.close();
    //this.sender.close();
  }

  startServer() async{
    this.pool = Soundpool(streamType: StreamType.notification);
    this.sender = await UDP.bind(Endpoint.any(port: Port(9000)));
    
    var _address = InternetAddress("192.168.0.2");
    var unicastEndpoint = Endpoint.unicast(_address, port: Port(9000));
   // this.sender = await UDP.bind(unicastEndpoint);
    //this.receiver = await UDP.bind(Endpoint.loopback(port: Port(9000)));

    String scanUp = "scanner_up";
    //await this.sender.send(scanUp.codeUnits, Endpoint.broadcast(port: Port(9000)));
    await this.sender.send(scanUp.codeUnits, unicastEndpoint);
      // receiving\listening
      // await receiver.listen((datagram) {
      //   var str = String.fromCharCodes(datagram.data);
      // // stdout.write(str);
      // print("Mensaje de servidor" + str);

      // }, timeout: Duration(seconds: 20));
  }

 enviarUdp(barcode) async {
     // creates a UDP instance and binds it to the first available network
  // interface on port 65000.
  // send a simple string to a broadcast endpoint on port 65001.
 // var dataLength = await this.sender.send(barcode.codeUnits, Endpoint.broadcast(port: Port(9000)));
  var _address = InternetAddress("192.168.0.2");
  var unicastEndpoint = Endpoint.unicast(_address, port: Port(9000));
  var dataLength = await this.sender.send(barcode.codeUnits, unicastEndpoint);
  this._playSound();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Escanner'),
          backgroundColor: Colors.black,
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scanOneCode,
                    child: const Text('Escannear un producto')
                ),
              )
              ,
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.teal,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scanMultipleCodes,
                    child: const Text('Escannear Multiples productos')
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              //   child: Text(barcode, textAlign: TextAlign.center,),
              // )
              // ,
            ],
          ),
        ));
  }

  Future<void> _playSound() async{
    int soundId = await rootBundle.load("sounds/sound.mp3").then((ByteData soundData) {
                  return this.pool.load(soundData);
                });
    int streamId = await this.pool.play(soundId);
  }


  Future scanOneCode() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => {
          this.barcode = barcode,
        }
      );
      await this.enviarUdp(barcode);
        
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'El usuario no autorizo el uso de la camara!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }


  Future scanMultipleCodes() async {
    try {
      while(true){
         String barcode = await BarcodeScanner.scan();
          setState(() => {
          this.barcode = barcode,
        });

        await this.enviarUdp(barcode);
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'El usuario no autorizo el uso de la camara!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }



}