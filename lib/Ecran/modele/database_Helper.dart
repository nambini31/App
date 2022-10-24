import 'dart:io';

import 'package:app/Ecran/modele/magasin.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
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
    String dataDirectory = join(directory.path, "dat5.db");
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
    await db.execute("""

          CREATE TABLE art_nouv( 
          id	INTEGER PRIMARY KEY, 
          libele	TEXT NOT NULL,
          prix	INTEGER NOT NULL,
          gencode	INTEGER NOT NULL,
          magasin	TEXT NOT NULL,
          image TEXT NULL
          
          )
    """);
  }
}
