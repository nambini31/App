// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:app/Ecran/Pages/index.dart';
import 'package:app/Ecran/modele/preparation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class ListesTop1000 extends StatefulWidget {
  Preparation prep = Preparation();
  ListesTop1000({required this.prep});

  @override
  State<ListesTop1000> createState() => _ListesTop1000State();
}

class _ListesTop1000State extends State<ListesTop1000> {
  String dateTime() {
    var date = DateTime.now();
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(
              text: "Tous",
            ),
            Tab(
              text: "En attente",
            ),
            Tab(
              text: "Valider",
            )
          ]),
          centerTitle: true,
          title: Text("TOP 1000"),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => index(1),
                    ));
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: TabBarView(children: [
          Container(
            color: Colors.amber,
          ),
          Container(
            color: Colors.white,
          ),
          Container(
            color: Colors.green,
          )
        ]),
      ),
    );
  }
}
