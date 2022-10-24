import 'package:app/Ecran/modele/database_Helper.dart';
import 'package:app/Ecran/modele/magasin.dart';
import 'package:sqflite/sqflite.dart';

class dataItem {
  Future<Item> AjoutItem(Item item) async {
    Database db = await DatabaseHelper().database;
    String nom = item.nom;
    item.id = await db.insert("item", item.toMap());
    //await db.rawInsert("INSERT INTO Item(nom) values('$nom')");
    print(item.id);

    return item;
  }

  Future DeleteItem(int id) async {
    Database db = await DatabaseHelper().database;
    await db.rawDelete("DELETE FROM item WHERE id = $id ");
  }

  Future UpdateItem(Item item) async {
    Database db = await DatabaseHelper().database;

    await db.update("Item", item.toMap(), where: "id = ?", whereArgs: [item.id]);
  }

  Future<List<Item>> SelectAll() async {
    List<Item> listes = [];
    Database db = await DatabaseHelper().database;

    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM Item");
    //List<Map<String, dynamic>> resulti = await db.query("Item", where: "", orderBy: "is ASC");
    result.forEach((MapElement) {
      Item item = Item();
      item.fromMap(MapElement);
      listes.add(item);
    });

    return listes;
  }
}
