// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:app/Ecran/Nouvelle%20Article/AjoutArticle.dart';
import 'package:app/Ecran/modele/database_Helper.dart';
import 'package:app/Ecran/modele/article.dart';
import 'package:app/Ecran/modele/preparation.dart';
import 'package:sqflite/sqflite.dart';

class DataPreparation {
  Future<Preparation> Charger() async {
    Database db = await DatabaseHelper().database;
    Preparation prep3 = Preparation.id(3, "Pa curiosité prep2", "blablabla bla jhihihi", "2022-09-11 09:53:10", 3);
    Preparation prep2 = Preparation.id(2, "Va prep", "blablabla bla jhihihi", "2022-11-11 20:53:10", 2);

    Preparation prep1 = Preparation.id(1, "Notre prep", "blablabla bla jhihihi", "2022-03-11 12:53:10", 1);
    try {
      await db.insert("preparation", prep1.toMap());
    } catch (e) {}

    try {
      await db.insert("preparation", prep2.toMap());
    } catch (e) {}
    try {
      await db.insert("preparation", prep3.toMap());
    } catch (e) {}
    //await db.rawQuery("DELETE FROM preparation");
    //int id = await db.rawInsert("INSERT INTO preparation(libele,prix,gencode,image,magasin) VALUES('coca',2225,656565665,'jhuik','oilkhgt')");
    //"INSERT INTO preparation(id,libele,prix,gencode,image,magasin) VALUES('${article.getLibele}','${article.getPrix}','${article.getGencode}','${article.getImage}','${article.getMagasin}')");

    return prep1;
  }

  Future DeletePreparation(int id) async {
    Database db = await DatabaseHelper().database;
    await db.delete("preparation", where: "id_prep = ?", whereArgs: [id]);
    //await db.rawDelete("DELETE FROM Article WHERE id = $id ");
  }

  Future<List<Preparation>> SelectAll() async {
    List<Preparation> listes = [];
    Database db = await DatabaseHelper().database;

    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT preparation.*,enseigne.design_enseigne FROM preparation INNER JOIN enseigne ON preparation.id_enseigne = enseigne.id_enseigne");
    //List<Map<String, dynamic>> resulti = await db.query("Article", where: "", orderBy: "is ASC");
    result.forEach((MapElement) {
      Preparation article = Preparation();
      article.fromMap(MapElement);
      listes.add(article);
    });

    return listes;
  }
}
