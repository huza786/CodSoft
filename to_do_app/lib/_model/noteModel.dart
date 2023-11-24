import 'package:to_do_app/_model/Notes_db.dart';
import 'package:sqflite/sqflite.dart';

class noteModel {
  final int? id;
  final String? title;
  final String? description;
  int? IsCompleted = 0;

  noteModel({
    this.id,
    required this.title,
    required this.description,
    this.IsCompleted,
  });

  factory noteModel.fromSqfliteDatabase(Map<String, dynamic> map) => noteModel(
        id: map['id']?.toInt() ?? 0,
        title: map['title'] ?? "",
        description: map['description'] ?? "",
        IsCompleted: map['IsCompleted']?.toInt() ??
            0, // Change 'iscompleted' to 'IsCompleted'
      );
}
