import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:to_do_list/task.dart';

class TaskProvider {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'tasks.db'),
      onCreate: (database, version) async {
        await database.execute('CREATE TABLE tasks (' +
            'id INTEGER PRIMARY KEY AUTOINCREMENT,' +
            'task_type TINYINT NOT NULL,' +
            'title VARCHAR(50) NOT NULL,' +
            'description VARCHAR(255) NOT NULL,' +
            'due_date DATE NOT NULL,' +
            'status TINYINT(1) NOT NULL DEFAULT 0,' +
            'phone VARCHAR(9) NULL DEFAULT NULL,' +
            'email VARCHAR(255) NULL DEFAULT NULL' +
          ');',
        );
      },
      version: 1
    );
  }
  
  Future<int> createTask(Task task) async {
    final Database db = await initializeDB();
    return await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }
  
  Future<List<Task>> getTasks() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('tasks');
    return queryResult.map((e) => Task.fromMap(e)).toList();
  }
  
  Future<void> deleteTask(String id) async {
    final Database db = await initializeDB();
    
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}
