import 'package:flutter/material.dart';

import 'package:to_do_list/task-form-modal.dart';
import 'package:to_do_list/create-task-buttons.dart';
import 'package:to_do_list/task-provider.dart';
import 'package:to_do_list/task.dart';
import 'package:to_do_list/task-item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do list',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  bool isModalVisible = false;
  late TaskFormModal _taskFormModal;
  List<Task> tasksList = List.empty(growable: true);

  static late TaskProvider tasksProvider;

  @override
  void initState() {
    super.initState();
    _taskFormModal = TaskFormModal(getEmptyTask(), this);
    tasksProvider = TaskProvider();
    tasksProvider.initializeDB().whenComplete(() async {
      await _getTasksFromDb();
      setState(() {});
    });
  }

  Future<void> _getTasksFromDb() async {
    final List<Task> tasksList = await tasksProvider.getTasks();
    setState(() {
      this.tasksList = tasksList;
    });
  }

  void openModal(Task task) {
    setState(() {
      _taskFormModal = TaskFormModal(task, this);
      isModalVisible = true;
    });
  }

  void setAsDone(Task task) {
    setState(() {
      task.status = true;
    });
    task.save();
  }

  void deleteTask(Task task) {
    setState(() {
      tasksList.remove(task);
    });
    task.delete();
  }

  Task getEmptyTask() {
    return Task(
      TaskType.basic,
      '',
      '',
      DateTime.now(),
      false
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          children: <Widget>[
            Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CreateTaskButtons(myHomePageState: this),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 20.0, maxHeight: 500.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: tasksList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TaskItem(tasksList[index], this);
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () => {
                            openModal(getEmptyTask())
                          },
                          child: const Text('Add new'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isModalVisible,
              child: _taskFormModal,
            ),
          ],
        ),
      ),
    );
  }
}
