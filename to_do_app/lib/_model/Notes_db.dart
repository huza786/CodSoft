import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/_model/databse_service.dart';
import 'package:to_do_app/_model/noteModel.dart';

class NoteDb {
  final tablename = 'notes';
  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tablename(
      "id" INTEGER NOT NULL,
      "title" TEXT NOT NULL,
      "description" TEXT NOT NULL,
      "IsCompleted" INTEGER NOT NULL,
      PRIMARY KEY ("id" AUTOINCREMENT)
    );""");
  }

  Future<int> create(
      {required String title,
      required String description,
      required int IsCompleted}) async {
    final database = await Database_service().database;
    print('creting note');
    return await database.rawInsert(
        """INSERT INTO $tablename (title,description,IsCompleted) VALUES (?,?,?)""",
        [title, description, IsCompleted]);
  }

  Future<List<noteModel>> getAllNotes() async {
    final database = await Database_service().database;
    final notes =
        await database.rawQuery("""SELECT * from $tablename ORDER BY id""");
    print('getting all note');

    return notes.map((note) => noteModel.fromSqfliteDatabase(note)).toList();
  }

  Future<noteModel> fetchbyID(int id) async {
    final database = await Database_service().database;
    final note = await database
        .rawQuery("""SELECT * from $tablename WHERE id = ?""", [id]);
    print('fetching by id note');

    return noteModel.fromSqfliteDatabase(note.first);
  }

  Future<int> Update(
      {required int? id,
      required int? IsCompleted,
      required String? title,
      required String? description}) async {
    final database = await Database_service().database;
    print('updating note');

    return await database
        .update(
      tablename,
      {
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (IsCompleted != null) 'IsCompleted': IsCompleted,
      },
      where: 'id= ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    )
        .then((result) {
      print('Update result: $result');
      return result;
    }).catchError((error) {
      print('Update error: $error');
      return 0; // or handle the error in another way
    });
  }

  Future<void> Delete(int id) async {
    final database = await Database_service().database;
    print('deleting note');

    await database.rawDelete("DELETE FROM $tablename WHERE id = ?", [id]);
    getAllNotes();
  }
}
