// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:app/Ecran/Pages/index.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class Relever extends StatefulWidget {
  int id_prep;
  Relever(this.id_prep);

  @override
  State<Relever> createState() => _ReleverState();
}

class _ReleverState extends State<Relever> {
  List<DropdownMenuItem<String?>> listesvrai = [];

  int id_choix = 1;

  TextEditingController searchController = TextEditingController();
  TextEditingController prixController = TextEditingController();
  TextEditingController scanController = TextEditingController();

  Future recuperer() async {
    ["Rechercher article", "Scanner le code barre"].forEach((element) {
      listesvrai.add(DropdownMenuItem(
        value: id_choix.toString(),
        child: Text(element),
      ));
      setState(() {
        id_choix = id_choix + 1;
      });
    });
    setState(() => listesvrai);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperer();
    scanController.text = "82515896463";
    id_choix = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Relever de prix")),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => index.top(widget.id_prep),
                  ));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(5)),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: DropdownButtonFormField2(
                value: id_choix.toString(),
                items: listesvrai,
                hint: Text("Choix Relever"),
                onChanged: (value) {
                  id_choix = int.parse(value.toString());
                  setState(() => id_choix);

                  print(id_choix);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  filled: true,
                  //hintText: "Magasin",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                  //contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                  prefixIcon: Icon(
                    Icons.select_all,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: (id_choix == 1)
                  ? TextFormField(
                      controller: searchController,

                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                        //contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                        //labelText: "Nom",
                        hintText: "Rechercher article",
                        prefixIcon: Container(
                          width: 50,
                          child: Icon(
                            Icons.search,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        //libele = value;
                      },
                      onTap: () {
                        //print(valeur);
                      },
                      validator: (value) => value!.isEmpty ? "Veuillez entrer la designation" : null,
                      onSaved: (newValue) {
                        //nom = newValue!;
                      },
                      //onSubmitted: submit,
                    )
                  : TextFormField(
                      controller: scanController,

                      // textAlign: TextAlign.center,
                      enabled: false,
                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                        //contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                        //labelText: "Nom",
                        hintText: "Scan Code barre",
                        prefixIcon: Container(
                          margin: EdgeInsets.only(right: 20),
                          width: 55,
                          child: TextButton.icon(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.only(left: 7),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                )),
                            label: Text(""),
                            onPressed: () {},
                            icon: Icon(Icons.camera_alt),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        //libele = value;
                      },
                      onTap: () {
                        //print(valeur);
                      },
                      validator: (value) => value!.isEmpty ? "Veuillez entrer la designation" : null,
                      onSaved: (newValue) {
                        //nom = newValue!;
                      },
                      //onSubmitted: submit,
                    ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextFormField(
                controller: prixController,

                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                  //contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                  //labelText: "Nom",
                  hintText: "Entrer le Prix",
                  prefixIcon: Container(
                    width: 50,
                    child: Icon(
                      Icons.price_change_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
                onChanged: (value) {
                  //libele = value;
                },
                onTap: () {
                  //print(valeur);
                },
                validator: (value) => value!.isEmpty ? "Veuillez entrer la designation" : null,
                onSaved: (newValue) {
                  //nom = newValue!;
                },
                //onSubmitted: submit,
              ),
            )
          ],
        ),
      ),
    );
  }
}
