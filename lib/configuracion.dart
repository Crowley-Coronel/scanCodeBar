import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ConfiguracionScreen extends StatelessWidget {
  @override
  TextEditingController ip = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Configurar ip'),
        backgroundColor: Colors.black,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: TextFormField(
              controller: ip,
              decoration: const InputDecoration(
                  hintText: 'Introduce la ip',
                  hintStyle: TextStyle(color: Colors.blueAccent)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Porfavor introduce la ip';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: RaisedButton(
                color: Colors.black,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                onPressed: () {
                  _save(context);
                },
                child: const Text('Guardar IP')),
          ),
        ],
      )),
    );
  }

  _save(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'ip_config';
    //final value = '192.168.1.1106';
    prefs.setString(key, ip.text);
    showAlertDialog(context);
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(""),
      content: Text("Ip Guardada."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
