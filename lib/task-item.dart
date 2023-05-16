import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:to_do_list/main.dart';
import 'package:to_do_list/task.dart';

class TaskItem extends StatelessWidget {
  final MyHomePageState _myHomePageState;
  final Task _task;
  
  const TaskItem(this._task, this._myHomePageState, {super.key});

  IconData _getAppropriateIcon() {
    if (_task.isPhoneType) {
      return Icons.smartphone_outlined;
    } else if (_task.isEmailType) {
      return Icons.email_outlined;
    }

    return Icons.calendar_today_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(
        top: 20.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                _getAppropriateIcon(),
                color: Colors.blue,
                size: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Text(
                  _task.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: _task.status ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _myHomePageState.setAsDone(_task);
                },
                icon: const Icon(Icons.done),
              ),
              IconButton(
                onPressed: () {
                  _myHomePageState.openModal(_task);
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  _myHomePageState.deleteTask(_task);
                },
                icon: const Icon(Icons.delete),
              ),
              Text(
                'Due date: ${_task.dueDateFormatted}',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
