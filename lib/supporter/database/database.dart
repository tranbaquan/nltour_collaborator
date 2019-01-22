import 'dart:io';

import 'package:nltour_collaborator/model/collaborator.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    Directory document = await getApplicationDocumentsDirectory();
    String path = join(document.path, 'nlcollaborator.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Collaborator ("
          "first_name TEXT,"
          "last_name TEXT,"
          "personal_id TEXT,"
          "email TEXT PRIMARY KEY,"
          "gender INTEGER,"
          "avatar TEXT,"
          "phone_number TEXT,"
          "dob TEXT,"
          "country TEXT,"
          "main_language TEXT"
          ")");
    });
  }

  addTraveler(Collaborator collaborator) async {
    final db = await database;

    var data = await db.insert("Collaborator", collaborator.toDBMap());
    return data;
  }

  updateTraveler(Collaborator collaborator) async {
    final db = await database;
    var res = await db.update("Collaborator", collaborator.toDBMap(),
        where: "email = ?", whereArgs: [collaborator.email]);
    return res;
  }

  Future<Collaborator> getCollaborator(String email) async {
    final db = await database;
    var res = await db.query("Collaborator", where: "email = ?", whereArgs: [email]);
    return res.isNotEmpty ? Collaborator.fromDBMap(res.first) : null;
  }

  deleteTraveler(String email) async {
    final db = await database;
    return db.delete("Collaborator", where: "email = ?", whereArgs: [email]);
  }

  deleteAll() async {
    final db = await database;
    return db.rawDelete("DELETE from Collaborator");
  }

}
