class Task {
  Task(this.taskType, this.title, this.description, this.dueDate, this.status, this.phone, this.email);

  TaskType taskType;
  String title;
  String description;
  DateTime dueDate;
  bool status;
  String phone;
  String email;
}

enum TaskType {
  basic,
  email,
  phone
}
