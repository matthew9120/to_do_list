import 'package:flutter/material.dart';

import 'main.dart';

class CreateTaskButtons extends StatelessWidget {
  const CreateTaskButtons({required this.myHomePageState, super.key});

  final MyHomePageState myHomePageState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: myHomePageState.openCreateModal,
          style: TextButton.styleFrom(
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
            minimumSize: Size(MediaQuery.of(context).size.width - 50.0, 50.0),
            shape: const ContinuousRectangleBorder(
                side: BorderSide(
                    width: 2.0
                )
            ),
          ),
          child: const Text(''),
        ),
        ElevatedButton(
          onPressed: myHomePageState.openCreateModal,
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            minimumSize: const Size(50.0, 50.0),
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
            shape: const ContinuousRectangleBorder(
                side: BorderSide(
                    width: 2.0
                )
            ),
          ),
          child: const Text('+'),
        ),
      ],
    );
  }
}
