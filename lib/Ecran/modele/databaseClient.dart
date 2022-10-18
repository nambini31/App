import 'dart:io';

import 'package:app/Ecran/modele/item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseClient {
  Database? _database;

  Future get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await create();

      return _database;
    }
  }

  Future create() async {
    Directory directory = await getApplicationSupportDirectory();
    String dataDirectory = join(directory.path, "dat.db");
    var bdd = await openDatabase(
      dataDirectory,
      version: 1,
      onCreate: oncreate,
    );
    return bdd;
  }

  Future oncreate(Database db, int version) async {
    await db.execute("""
          CREATE TABLE Item( 
          id	INTEGER PRIMARY KEY, 
          nom	TEXT NOT NULL)
    """);
  }

  Future<Item> AjoutItem(Item item) async {
    Database db = await database;
    String nom = item.nom;
    item.id = await db.insert("item", item.toMap());
    //await db.rawInsert("INSERT INTO Item(nom) values('$nom')");
    print(item.id);

    return item;
  }

  Future DeleteItem(int id) async {
    Database db = await database;
    await db.rawDelete("DELETE FROM item WHERE id = $id ");
  }

  Future UpdateItem(Item item) async {
    Database db = await database;

    await db.update("Item", item.toMap(), where: "id = ?", whereArgs: [item.id]);
  }

  Future<List<Item>> SelectAll() async {
    List<Item> listes = [];
    Database db = await database;

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
