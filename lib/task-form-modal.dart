import 'dart:html';

import 'package:flutter/material.dart';

class TaskFormModal extends StatefulWidget {
  const TaskFormModal({super.key});

  @override
  State<StatefulWidget> createState() => _TaskFormModalState();
}

class _TaskFormModalState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 200,
          top: 200,
          child: Container(
            height: 500,
            width: 200,
            color: Color.fromRGBO(0, 255, 0, 1),
          ),
        ),
      ],
    );
  }
}
