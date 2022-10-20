// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unrelated_type_equality_checks

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';

import 'modele/databaseClient.dart';
import 'modele/item.dart';

class PagesNouveauArticle extends StatefulWidget {
  const PagesNouveauArticle({super.key});

  @override
  State<PagesNouveauArticle> createState() => _PagesNouveauArticleState();
}

class _PagesNouveauArticleState extends State<PagesNouveauArticle> {
  String? pathImage;
  File? fichierImage;
  String barcode = "";
  String valeur = "nio";
  TextEditingController codebar = TextEditingController();

  List<DropdownMenuItem<String?>> listesvrai = [];
  List<Container> listesvraii = [];

  List<Item> listeItem = [];

  String news = "";
  String news1 = "";

  void recuperer() async {
    await DatabaseClient().SelectAll().then((value) {
      listeItem = value;
      //setState(() => listeItem);
      listeItem.forEach((element) {
        print(element.nom);
        listesvrai.add(DropdownMenuItem(
          value: element.id.toString(),
          child: Text(element.nom),
        ));
      });
      setState(() => listesvrai);
    });
  }

  Future pickImage(ImageSource Sourc) async {
    var image = await ImagePicker().pickImage(source: Sourc);

    if (image != null) {
      setState(() {
        pathImage = image!.path;
        fichierImage = File(pathImage!);
      });
      // print("lien :$pathImage");
      // print(fichierImage);
    } else {
      print("image null");
    }
  }

  Future BarcodeScanner() async {
    String barcodeLocal;
    try {
      barcodeLocal = await FlutterBarcodeScanner.scanBarcode("#DF1C5D", "Annuler", true, ScanMode.BARCODE);
      if (barcodeLocal != "-1") {
        setState(() {
          barcode = barcodeLocal;
          codebar.text = barcode;
        });
      } else {
        setState(() {
          barcode = "";
          codebar.text = barcode;
        });
      }
    } catch (e) {
      setState(() {
        barcode = "";
        codebar.text = barcode;
      });
    }
  }

  Future alertCamera() async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => SimpleDialog(
          title: Text(
            "Choix",
            textAlign: TextAlign.center,
          ),
          children: [
            Container(
                width: 80,
                //height: 120,
                //padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Icon(Icons.browse_gallery_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Gallerie")
                            ],
                          ),
                          onTap: () {
                            pickImage(ImageSource.gallery);
                            Navigator.pop(context);
                          }),
                    ),
                    //Padding(padding: EdgeInsets.all(5)),
                    Container(
                      height: 50,
                      child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Icon(Icons.camera_alt),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Camera")
                            ],
                          ),
                          onTap: () {
                            pickImage(ImageSource.camera);
                            Navigator.pop(context);
                          }),
                    ),
                    Container(
                      height: 50,
                      child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Icon(Icons.delete),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Effacer")
                            ],
                          ),
                          onTap: () {
                            setState(() => fichierImage = null);
                            Navigator.pop(context);
                          }),
                    ),
                  ],
                ))
          ]),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajout Article"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 10,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(100)),
                    child: ClipOval(
                        child: (fichierImage == null)
                            ? null
                            : Image.file(
                                fichierImage!,
                                fit: BoxFit.cover,
                                //width: 50,
                              )),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    width: 70,
                    child: RawMaterialButton(
                        padding: EdgeInsets.all(12),
                        shape: CircleBorder(),
                        fillColor: Colors.lightBlue,
                        onPressed: () {
                          alertCamera();
                        },
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextFormField(
                  style: TextStyle(fontSize: 19),

                  autocorrect: false,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 3),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                    //contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                    //labelText: "Nom",
                    hintText: "Entrer la designation",
                    prefixIcon: Icon(
                      Icons.article_outlined,
                      color: Colors.blue,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      //nom = value;
                    });
                  },
                  onTap: () {
                    print(valeur);
                  },
                  validator: (value) => value!.isEmpty ? "Veuillez entrer votre nom" : null,
                  onSaved: (newValue) {
                    //nom = newValue!;
                  },
                  //onSubmitted: submit,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextFormField(
                  style: TextStyle(fontSize: 19),
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 3),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                    //contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                    //labelText: "Designation",
                    hintText: "Entrer le prix",
                    prefixIcon: Icon(
                      Icons.price_change_outlined,
                      color: Colors.blue,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      //nom = value;
                    });
                  },
                  validator: (value) => value!.isEmpty ? "Veuillez entrer votre nom" : null,
                  onSaved: (newValue) {
                    //nom = newValue!;
                  },
                  //onSubmitted: submit,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: DropdownButtonFormField(
                  //value: valeur,
                  //itemHeight:  <String>['Chien', 'Chat', 'Tigre', 'Lion'].map((e) => ),

                  alignment: Alignment.center,

                  items: listesvrai,
                  hint: Text("Choix Magasin"),
                  onChanged: (value) {
                    valeur = value!;
                    setState(
                      () => valeur,
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 3),
                    filled: true,
                    //hintText: "Magasin",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                    //contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                    prefixIcon: Icon(
                      Icons.price_change_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                      onPressed: () {
                        BarcodeScanner();
                      },
                      icon: Icon(Icons.camera_alt),
                      label: Text("Scan Barcode")),
                  Text("==========="),
                  Padding(padding: EdgeInsets.only(top: 13)),
                  Container(
                    width: 200,
                    child: TextFormField(
                      controller: codebar,
                      style: TextStyle(
                        fontSize: 19,
                      ),
                      textAlign: TextAlign.center,
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 3),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),

                        //labelText: "Designation",
                        hintText: "Barcode Generer",
                      ),
                      onChanged: (value) {
                        setState(() {
                          //nom = value;
                        });
                      },
                      validator: (value) => value!.isEmpty ? "Veuillez entrer votre nom" : null,
                      onSaved: (newValue) {
                        //nom = newValue!;
                      },
                      //onSubmitted: submit,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
