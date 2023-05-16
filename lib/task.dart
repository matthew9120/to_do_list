import 'package:flutter/material.dart';
import 'package:to_do_list/helper.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/task-provider.dart';

class Task {
  int? id;
  TaskType taskType;
  String title;
  String description;
  DateTime dueDate;
  bool status;
  String? phone;
  String? email;

  Task(this.taskType, this.title, this.description, this.dueDate, this.status);

  Task.fromMap(Map<String, dynamic> item):
    id = item['id'],
    taskType = item['task_type'] == 0 ? TaskType.basic :
      (item['task_type'] == 1 ? TaskType.phone : TaskType.email),
    title = item['title'],
    description = item['description'],
    dueDate = Helper.parseDateFromDB(item['due_date']),
    status = item['status'] == 1 ? true : false,
    phone = item['phone'],
    email = item['email'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'task_type': _getTaskTypeId(),
      'title': title,
      'description': description,
      'due_date': '${dueDate.year}-${dueDate.month}-${dueDate.day}',
      'status': status ? 1 : 0,
      'phone': phone,
      'email': email
    };
  }

  int _getTaskTypeId() {
    if (taskType == TaskType.phone) {
      return 1;
    } else if (taskType == TaskType.email) {
      return 2;
    }

    return 0;
  }

  void save() {
    MyHomePageState.tasksProvider.createTask(this);
  }

  void delete() {
    MyHomePageState.tasksProvider.deleteTask(id.toString());
  }

  bool get isEmailType {
    return taskType == TaskType.email;
  }

  bool get isPhoneType {
    return taskType == TaskType.phone;
  }

  String get dueDateFormatted {
    return Helper.formatDate(dueDate);
  }
}

enum TaskType {
  basic,
  email,
  phone
}
