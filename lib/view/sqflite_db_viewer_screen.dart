import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_db_viewer/sqflite_db_viewer.dart';

class SqfliteViewerScreen extends StatefulWidget {
  const SqfliteViewerScreen({super.key});

  @override
  State<SqfliteViewerScreen> createState() => _SqfliteViewerScreenState();
}

class _SqfliteViewerScreenState extends State<SqfliteViewerScreen> {
  late DbViewer dbViewer;
  List<Map<String, dynamic>>? listMap;
  late final path;
  late Database db;

  void initDb() async {
    final databasesPath = await getDatabasesPath();
    path = databasesPath + "/ztasks.db";
    db = await openDatabase(path);
    dbViewer = DbViewer(db: db, tableName: "taskTable");
    listMap = await dbViewer.getAllItems();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      initDb();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sqflite Viewer'),
        ),
        body: Center(child: Text(listMap.toString())));
  }
}
