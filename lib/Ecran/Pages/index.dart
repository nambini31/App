// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app/Ecran/Pages/Acceuil.dart';
import 'package:app/Ecran/Pages/ListesMagasin.dart';
import 'package:app/Ecran/Pages/ListesNouveauArticle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class index extends StatefulWidget {
  const index({super.key});

  @override
  State<index> createState() => _indexState();
}

class _indexState extends State<index> {
  int i = 0;

  List<Widget> pages = [Acceuil(), ListesNouveauArticle(), ListesMagasin()];

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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Acceuil"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Article"),
          BottomNavigationBarItem(icon: Icon(Icons.shop_rounded), label: "Magasin"),
        ],
        currentIndex: i,
        onTap: onItemTap,
      ),
    );
  }
}
