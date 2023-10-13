library sqflite_db_viewer;

import 'package:sqflite/sqflite.dart';

class DbViewer {
  final Database db;
  final String tableName;

  DbViewer({required this.db, required this.tableName});

  Future<int> saveItem({required dynamic item}) async {
    item.id = await db.insert(tableName, item.toMap());
    return item.id;
  }

  Future<dynamic> getItem(
      {required int id,
      required String columnId,
      List<String>? columnList,
      dynamic item}) async {
    List<Map<String, dynamic>> maps = await db.query(tableName,
        columns: columnList, where: "$columnId = ?", whereArgs: [id]);

    if (maps.isNotEmpty) {
      return item.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getAllItems() async {
    List<Map<String, dynamic>> listMap = [];

    listMap = await db.rawQuery("SELECT * FROM $tableName");

    return listMap;
  }
}
