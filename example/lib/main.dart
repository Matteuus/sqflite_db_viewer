import 'package:example/db_helper.dart';
import 'package:example/task_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_db_viewer/sqflite_db_viewer.dart';
import 'package:sqflite_db_viewer/view/sqflite_db_viewer_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TaskHelper taskHelper;
  late DbViewer dbViewer;
  late Task task;
  @override
  void initState() {
    task = Task(
      desc: 'Testando sqflite_db_viewer',
    );
    taskHelper = TaskHelper();
    taskHelper.saveTask(task).then((value) => debugPrint('id: $value'));
    super.initState();
  }

  void _incrementCounter() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SqfliteViewerScreen(),
      ),
    );
    setState(() {
      taskHelper.getAllTasks().then((value) => debugPrint('tasks: $value'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
