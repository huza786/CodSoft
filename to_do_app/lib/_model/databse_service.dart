import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/_model/Notes_db.dart';

class Database_service {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      print('database initilized already');

      return _database!;
    }
    _database = await _initialize();
    print('trying to initialize');

    return _database!;
  }

  Future<String> get _fullPath async {
    const name = 'notes.db';
    final path = await getDatabasesPath();
    print('joining path to name database');
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await _fullPath;
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await NoteDb().createTable(db);
        print('Creating table ');
      },
    );
  }
}
