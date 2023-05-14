import 'package:flutter/material.dart';

import 'package:to_do_list/task.dart';

class TaskFormModal extends StatefulWidget {
  const TaskFormModal(this._task, {super.key});

  final Task _task;

  @override
  State<StatefulWidget> createState() => _TaskFormModalState(_task);
}

class _TaskFormModalState extends State<StatefulWidget> {
  _TaskFormModalState(this._task);

  final Task _task;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isEmailType = false;
  bool _isPhoneType = false;

  void _save() {

  }

  @override
  Widget build(BuildContext context) {
    double seventyFivePercentOfScreenWidth = MediaQuery.of(context).size.width / 4 * 3;
    double halfOfTwentyFivePercentOfScreenWidth = MediaQuery.of(context).size.width / 8;

    return Container(
      height: MediaQuery.of(context).size.height - 100.0,
      width: seventyFivePercentOfScreenWidth,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
          Visibility(
            visible: _isPhoneType,
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
            visible: _isPhoneType,
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Visibility(
            visible: _isEmailType,
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
            visible: _isEmailType,
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.phone,
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
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Status'),
              Checkbox(
                value: _task.status,
                onChanged: (status) => {
                  if (status == true) {
                    _task.status = true
                  } else {
                    _task.status = false
                  }
                },
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20.0,
            ),
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _save,
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
    );
  }
}
