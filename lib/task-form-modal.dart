import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:to_do_list/helper.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/task.dart';

class TaskFormModal extends StatefulWidget {

  final MyHomePageState _myHomePageState;
  final Task _task;

  const TaskFormModal(this._task, this._myHomePageState, {super.key});

  @override
  State<StatefulWidget> createState() => _TaskFormModalState(_task, _myHomePageState);
}

class _TaskFormModalState extends State<StatefulWidget> {

  final Task _task;
  final MyHomePageState _myHomePageState;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dueDateController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  String? _dateErrorText;

  _TaskFormModalState(this._task, this._myHomePageState) {
    _setValuesFromTask();
  }

  void _setValuesFromTask() {
    _titleController = TextEditingController(text: _task.title);
    _descriptionController = TextEditingController(text: _task.description);
    _dueDateController = TextEditingController(text: Helper.formatDate(_task.dueDate));
    _phoneController = TextEditingController(text: _task.phone);
    _emailController = TextEditingController(text: _task.email);
  }

  void _saveAndClose() {
    _task.title = _titleController.text;

    if (_task.title.isNotEmpty) {
      DateTime inputDate;
      try {
        inputDate = Helper.parseDate(_dueDateController.text);
      } catch (e) {
        setState(() {
          _dateErrorText = 'Invalid date format';
        });
        return;
      }

      setState(() {
        _dateErrorText = null;
      });

      _task.dueDate = inputDate;
      _task.phone = _phoneController.text;
      _task.email = _emailController.text;
      _task.description = _descriptionController.text;

      _task.save();
      _myHomePageState.setState(() {
        int taskIndex = _myHomePageState.tasksList.indexOf(_task);
        if (taskIndex > -1) {
          _myHomePageState.tasksList[taskIndex] = _task;
        } else {
          _myHomePageState.tasksList.add(_task);
        }
      });
    }

    _myHomePageState.setState(() {
      _myHomePageState.isModalVisible = false;
    });
  }
  
  void _changeTaskType(dynamic selectedType) {
    setState(() {
      _task.taskType = selectedType;
    });
  }

  @override
  Widget build(BuildContext context) {
    double seventyFivePercentOfScreenWidth = MediaQuery.of(context).size.width / 4 * 3;
    double halfOfTwentyFivePercentOfScreenWidth = MediaQuery.of(context).size.width / 8;

    return Container(
        margin: EdgeInsets.only(
          top: 60.0,
          right: halfOfTwentyFivePercentOfScreenWidth,
          left: halfOfTwentyFivePercentOfScreenWidth,
        ),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: Colors.black,
          ),
          color: Colors.white,
        ),
        child: SizedBox(
          width: seventyFivePercentOfScreenWidth,
          height: MediaQuery.of(context).size.height - 200.0,
          child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                bottom: 20.0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Title:'),
                  Icon(Icons.edit),
                ],
              ),
            ),
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(
                bottom: 20.0,
              ),
              child: const Text('Task type:'),
            ),
            DropdownButtonFormField(
              value: _task.taskType,
              isExpanded: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: const <DropdownMenuItem>[
                DropdownMenuItem<TaskType>(
                  value: TaskType.basic,
                  child: Text('Task to do')
                ),
                DropdownMenuItem<TaskType>(
                  value: TaskType.email,
                  child: Text('Send an e-mail'),
                ),
                DropdownMenuItem<TaskType>(
                  value: TaskType.phone,
                  child: Text('Make a phone call'),
                ),
              ],
              onChanged: _changeTaskType
            ),
            Visibility(
              visible: _task.isPhoneType,
              child: Container(
                margin: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0
                ),
                alignment: Alignment.centerLeft,
                child: const Text('Phone:'),
              ),
            ),
            Visibility(
              visible: _task.isPhoneType,
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 9,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Visibility(
              visible: _task.isEmailType,
              child: Container(
                margin: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0
                ),
                alignment: Alignment.centerLeft,
                child: const Text('E-mail:'),
              ),
            ),
            Visibility(
              visible: _task.isEmailType,
              child: TextField(
                controller: _emailController,
                maxLength: 255,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter(RegExp(r'[\w\d+@.]'), allow: true)
                ],
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 20.0
              ),
              alignment: Alignment.centerLeft,
              child: const Text('Due date:'),
            ),
            TextField(
              controller: _dueDateController,
              keyboardType: TextInputType.datetime,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
              ],
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                errorText: _dateErrorText,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 20.0,
              ),
              alignment: Alignment.centerLeft,
              child: const Text('Description:'),
            ),
            TextField(
              controller: _descriptionController,
              minLines: 2,
              maxLines: 2,
              maxLength: 250,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Done'),
                  Checkbox(
                    value: _task.status,
                    onChanged: (status) => {
                      setState(() {
                        if (status == true) {
                          _task.status = true;
                        } else {
                          _task.status = false;
                        }
                      })
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 20.0,
              ),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _saveAndClose,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  minimumSize: const Size(250.0, 70.0),
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
                  shape: const ContinuousRectangleBorder(
                      side: BorderSide(
                          width: 2.0
                      )
                  ),
                ),
                child: const Text('Save/Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
