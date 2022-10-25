// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:app/Ecran/Pages/AucuneDonnes.dart';
import 'package:app/Ecran/Pages/ListesTop1000.dart';
import 'package:app/Ecran/Pages/two_letter_icon.dart';
import 'package:app/Ecran/modele/dataPreparation.dart';
import 'package:app/Ecran/modele/database_Helper.dart';
import 'package:app/Ecran/modele/preparation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sqflite/sqflite.dart';

class ListesToutesTop1000 extends StatefulWidget {
  const ListesToutesTop1000({super.key});

  @override
  State<ListesToutesTop1000> createState() => _ListesToutesTop1000State();
}

class _ListesToutesTop1000State extends State<ListesToutesTop1000> {
  List<Preparation> listes = [];
  Preparation prepTop = Preparation();

  Future recuperer() async {
    await DataPreparation().SelectAll().then((value) {
      //print()
      setState(() {
        listes = value;
      });
    });
    return listes;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperer();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: GestureDetector(
            onTap: () {
              //print("clicked");
              //Slidable.of(context)!.close(duration: Duration(seconds: 0));
            },
            child: SlidableAutoCloseBehavior(
              closeWhenOpened: true,
              closeWhenTapped: true,
              child: Center(
                child: (listes.isEmpty)
                    ? AucuneDonnes()
                    : ListView.builder(
                        itemCount: listes.length,
                        itemBuilder: (context, index) {
                          Preparation prep = listes[index];

                          return SingleChildScrollView(
                            child: Slidable(
                              endActionPane: ActionPane(motion: ScrollMotion(), extentRatio: 0.5, children: [
                                SlidableAction(
                                  onPressed: (context) {},
                                  label: "Valider",
                                  backgroundColor: Colors.green,
                                  icon: Icons.add_home,
                                ),
                                Padding(padding: EdgeInsets.all(2)),
                                SlidableAction(
                                  onPressed: (context) {
                                    alerte1(prep);
                                    recuperer();
                                  },
                                  label: "Delete",
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                ),
                              ]),
                              child: ListTile(
                                  onTap: () {},
                                  title: Center(child: Text(prep.libelle_prep)),
                                  subtitle: Center(child: Text(prep.design_magasin)),
                                  leading: TwoLetterIcon(prep.libelle_prep),
                                  trailing: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward))),
                            ),
                          );
                        }),
              ),
            )),
      ),
    );
  }

  Future alerte1(Preparation prep) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((BuildContext context) {
          return SimpleDialog(
            // ignore: prefer_const_constructors
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
                        DataPreparation().DeletePreparation(prep.id_prep);
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
