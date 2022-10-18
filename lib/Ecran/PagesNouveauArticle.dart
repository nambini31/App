// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';
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

  String valeur = "nio";

  List<DropdownMenuItem<String?>> listesvrai = [];

  List<Item> listeItem = [];

  String news = "";
  String news1 = "";

  void recuperer() async {
    await DatabaseClient().SelectAll().then((value) {
      listeItem = value;
      //setState(() => listeItem);
      listeItem.forEach((element) {
        print(element.nom);
        listesvrai.add(DropdownMenuItem(value: element.id.toString(), child: Text(element.nom)));
      });
      setState(() => listesvrai);
    });
  }

  Future pickImage(ImageSource Sourc) async {
    var image = await ImagePicker().pickImage(source: Sourc);
    setState(() {
      pathImage = image!.path;
      fichierImage = File(pathImage!);
    });
    print("lien :$pathImage");
    print(fichierImage);
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
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                child: ClipOval(
                    clipBehavior: Clip.hardEdge,
                    child: (fichierImage == null)
                        ? Image.asset("lib\\image\\varika1.png")
                        : Image.file(
                            fichierImage!,
                            fit: BoxFit.cover,
                            width: 50,
                          )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: Icon(Icons.browse_gallery_rounded),
                    label: Text("Browse"),
                    style:
                        ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue), foregroundColor: MaterialStatePropertyAll(Colors.white)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton.icon(
                    onPressed: () => pickImage(ImageSource.camera),
                    icon: Icon(Icons.camera),
                    label: Text("Camera"),
                    style:
                        ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue), foregroundColor: MaterialStatePropertyAll(Colors.white)),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                //height: 80,
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
              Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                //height: 80,
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

                    //labelText: "Nom",
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
              Padding(padding: EdgeInsets.all(10)),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
                  //value: valeur,
                  //itemHeight:  <String>['Chien', 'Chat', 'Tigre', 'Lion'].map((e) => ),

                  alignment: Alignment.center,

                  items: listesvrai,
                  hint: Text("Data select"),
                  onChanged: (value) {
                    valeur = value!;
                    setState(
                      () => valeur,
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 3),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                    //contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    prefixIcon: Icon(
                      Icons.price_change_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
