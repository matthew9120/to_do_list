class Task {
  Task(this.taskType, this.title, this.description, this.dueDate, this.status);

  TaskType taskType;
  String title;
  String description;
  DateTime dueDate;
  bool status;
  String? phone;
  String? email;

  bool get isEmailType {
    return taskType == TaskType.email;
  }

  bool get isPhoneType {
    return taskType == TaskType.phone;
  }
}

enum TaskType {
  basic,
  email,
  phone
}
