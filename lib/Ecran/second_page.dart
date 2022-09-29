// ignore_for_file: unused_import, use_key_in_widget_constructors, no_logic_in_create_state, prefer_const_constructors, non_constant_identifier_names, unused_local_variable,

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Secondpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return Homesecond();
  }
}

class Homesecond extends State<Secondpage> {
  String change = "";
  String submit = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("seconde page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: alerte, child: Text("alert dialog")),
            ElevatedButton(onPressed: alerte1, child: Text("simple dialog")),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                setState(() {
                  change = value;
                });
              },
              onSubmitted: (String value) {
                setState(() {
                  submit = value;
                });
              },
              decoration: InputDecoration(labelText: "Votre nom"),
            ),
            Text(change),
            Text(submit),
          ],
        ),
      ),
    );
  }

  void create_snack() {
    SnackBar snack = SnackBar(content: Text("voici le snackbar"));
    //Scaffold.of(context).showBottomSheet(
    //(context) => snack,
    //);
  }

  Future alerte1() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((BuildContext context) {
          return SimpleDialog(
            title: Text("simple dialog"),
            contentPadding: EdgeInsets.all(10),
            children: [
              Text("errerrrrrrrrrrrrrrrrrrrrrrrrdssssssssssssssssssssssssssssdsddddddddddddd"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OUI")),
            ],
          );
        }));
  }

  Future alerte() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((BuildContext context) {
          return AlertDialog(
            title: Text("etez vous Sur que ca marche"),
            content: Text("je ne sais pas"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OUI")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("NON"))
            ],
          );
        }));
  }
}
