// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:io';
import 'package:app/Ecran/AucuneDonnes.dart';
import 'package:app/Ecran/PagesNouveauArticle.dart';
import 'package:app/Ecran/modele/databaseClient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';

import 'modele/item.dart';

class PagesListes extends StatefulWidget {
  const PagesListes({super.key});

  @override
  State<PagesListes> createState() => _PagesListeState();
}

enum Actions { Update, Delete }

class _PagesListeState extends State<PagesListes> {
  TextEditingController nom = TextEditingController();
  TextEditingController nom1 = TextEditingController();
  List<Item> listes = [];

  String news = "";
  String news1 = "";

  void recuperer() async {
    await DatabaseClient().SelectAll().then((value) {
      listes = value;
      setState(() => listes);
    });
  }

  @override
  void initState() {
    // TODO: implement initStatess
    super.initState();
    recuperer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listes des items"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PagesNouveauArticle(),
                    ));
              },
              icon: Icon(Icons.article))
        ],
      ),
      body: SlidableAutoCloseBehavior(
        closeWhenOpened: true,
        closeWhenTapped: true,
        child: Center(
          child: (listes.isEmpty)
              ? AucuneDonnes()
              : ListView.builder(
                  itemCount: listes.length,
                  itemBuilder: (context, index) {
                    Item item = listes[index];
                    return SingleChildScrollView(
                      child: Slidable(
                        endActionPane: ActionPane(motion: ScrollMotion(), extentRatio: 0.5, children: [
                          SlidableAction(
                            onPressed: (context) {
                              alerte1(item);
                            },
                            label: "Delete",
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          SlidableAction(
                            onPressed: (context) {
                              nom1.text = item.nom;
                              alertmodif(item);
                            },
                            label: "Update",
                            backgroundColor: Colors.blue,
                            icon: Icons.update,
                          )
                        ]),
                        child: ListTile(
                            onTap: () {},
                            title: Text(item.nom),
                            subtitle: Text(item.id.toString()),
                            leading: Icon(Icons.home),
                            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.shower))),
                      ),
                    );
                  }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: alert,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future alert() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Container(
          width: 100,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 45,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      news = value;
                    });
                  },
                  controller: nom,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(2),
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    Item item = Item();
                    item.nom = news;
                    DatabaseClient().AjoutItem(item);
                    print("ajout");
                    recuperer();
                    Navigator.pop(context);
                  },
                  child: Text("Ajouter"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future alertmodif(Item item) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 45,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        news1 = value;
                      });
                    },
                    controller: nom1,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(2),
                        filled: true,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              item.nom = news1;
                              DatabaseClient().UpdateItem(item);
                              print("Modif");
                              print(news1);
                              recuperer();
                            },
                            child: Text("Update")),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                            ))
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future alerte1(Item item) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((BuildContext context) {
          return SimpleDialog(
            title: Text(
              "simple dialog",
              style: TextStyle(),
            ),
            contentPadding: EdgeInsets.all(10),
            children: [
              Text("Suppression definitive"),
              SizedBox(
                width: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        DatabaseClient().DeleteItem(item.id);
                        recuperer();
                      },
                      child: Text("OUI")),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Non",
                      ))
                ],
              )
            ],
          );
        }));
  }
}
