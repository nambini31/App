// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'package:app/Ecran/Pages/Acceuil.dart';
import 'package:app/Ecran/Pages/ListesMagasin.dart';
import 'package:app/Ecran/Pages/ListesNouveauArticle.dart';
import 'package:app/Ecran/Pages/ListesPreparation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class index extends StatefulWidget {
  int i = 0;
  index(this.i);

  @override
  State<index> createState() => _indexState();
}

class _indexState extends State<index> {
  int i = 0;

  @override
  void initState() {
    super.initState();
    i = widget.i;
  }

  List<Widget> pages = [Acceuil(), ListesPreparation(), ListesNouveauArticle(), ListesMagasin()];

  void onItemTap(int index) {
    setState(() {
      i = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: pages[i],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Acceuil"),
          BottomNavigationBarItem(icon: Icon(Icons.compare), label: "Relever"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Article"),
          BottomNavigationBarItem(icon: Icon(Icons.shop_rounded), label: "Magasin"),
        ],
        currentIndex: i,
        onTap: onItemTap,
      ),
    );
  }
}
