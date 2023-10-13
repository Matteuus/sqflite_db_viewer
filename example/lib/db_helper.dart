import 'dart:async';

import 'package:example/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_db_viewer/sqflite_db_viewer.dart';

class TaskHelper {
  static final TaskHelper _instance = TaskHelper.internal();

  factory TaskHelper() => _instance;

  TaskHelper.internal();

  Database? _db;
  DbViewer? dbViewer;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "ztasks.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $taskTable($idColumn INTEGER PRIMARY KEY, $descColumn TEXT, $checkColumn BOOLEAN NOT NULL DEFAULT (0))");
      // Inicializa o dbViewer
      dbViewer = DbViewer(db: db, tableName: taskTable);
    });
  }

  // Salva task no banco
  Future<Task> saveTask(Task task) async {
    await db;
    task.id = await dbViewer!.saveItem(item: task);
    return task;
  }

  Future<Task?> getTask(int id) async {
    await db;
    return await dbViewer?.getItem(
        id: id, columnId: idColumn, columnList: [idColumn, descColumn]);
  }

  Future<List<dynamic>?> getAllTasks() async {
    await db;
    List<Task> listTask = [];
    List<Map<String, dynamic>>? listMap = await dbViewer?.getAllItems();

    for (Map<String, dynamic> m in listMap!) {
      listTask.add(Task.fromMap(m));
    }

    return listTask;
  }

  Future<int> deleteTask(int id) async {
    Database dbTask = await db;
    return await dbTask
        .delete(taskTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateTask(Task task) async {
    Database dbTask = await db;
    return await dbTask.update(taskTable, task.toMap(),
        where: "$idColumn = ?", whereArgs: [task.id]);
  }

  Future<int?> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT(*) FROM $taskTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}
