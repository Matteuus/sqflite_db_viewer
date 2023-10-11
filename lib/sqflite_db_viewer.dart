library sqflite_db_viewer;

import 'package:sqflite/sqflite.dart';

/// A Calculator.
// class Calculator {
//   /// Returns [value] plus 1.
//   int addOne(int value) => value + 1;
// }

class DbViewer {
  final Database db;
  final String tableName;

  DbViewer({required this.db, required this.tableName});

  Future saveItem({required dynamic item}) async {
    // Database database = await db;
    item.id = await db.insert(tableName, item.toMap());
    print('itemId: ${item.id}');
    return item;
  }

  Future<dynamic> getItem(
      {required int id,
      required String columnId,
      List<String>? columnList,
      dynamic item}) async {
    List<Map<String, dynamic>> maps = await db.query(tableName,
        columns: columnList, where: "$columnId = ?", whereArgs: [id]);

    if (maps.isNotEmpty) {
      print('item: $item');
      return item.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List> getAllItems({required dynamic item}) async {
    List<Map<String, dynamic>> listMap =
        await db.rawQuery("SELECT * FROM $tableName");
    List listItem = [];
    for (Map<String, dynamic> m in listMap) {
      listItem.add(item.fromMap(m));
    }

    print('listItem: $listItem');
    return listItem;
  }
}
