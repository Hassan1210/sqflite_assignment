import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqlite_assingnment/Sqflite/contact_modle.dart';

class DbHelper {
  final String _dbName = "Contact.db";
  int dbVersion = 1;

  static Database? _database;
  DbHelper._privateConstructor();
  static final DbHelper intance = DbHelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await inializeDataBase();
    return _database;
  }

  inializeDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${Table.tableName} (
      ${Table.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${Table.columnName} TEXT NOT NULL,
      ${Table.columnPhone} TEXT NOT NULL
      )
      ''');
  }

  Future<int> insert(Contact contact) async {
    Database? db = await intance.database;
    return db!.insert(Table.tableName, contact.toMap());
  }

  Future<List<Contact>> getContact() async {
    Database? db = await intance.database;
    List<Map> contact = await db!.query(Table.tableName);

    return contact.isEmpty
        ? []
        : contact.map((e) => Contact.fromMap(e)).toList();
  }

  Future<int> delete(int? id) async {
    Database? db = await intance.database;

    return await db!.delete(Table.tableName,
        where: '${Table.columnId} =?', whereArgs: [id]);
  }

  Future<int> update(Contact contact, int id) async {
    Database? db = await intance.database;

    return await db!.update(Table.tableName, contact.toMap(),
        where: '${Table.columnId} =?', whereArgs: [id]);
  }
}
