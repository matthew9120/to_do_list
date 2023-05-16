import 'package:flutter/material.dart';

import 'package:to_do_list/main.dart';

class CreateTaskButtons extends StatelessWidget {
  const CreateTaskButtons({required this.myHomePageState, super.key});

  final MyHomePageState myHomePageState;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 50.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              myHomePageState.openModal(myHomePageState.getEmptyTask());
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
              minimumSize: Size(MediaQuery.of(context).size.width - 50.0, 50.0),
              shape: const ContinuousRectangleBorder(
                side: BorderSide(
                  width: 2.0
                ),
              ),
            ),
            child: const Text(''),
          ),
          ElevatedButton(
            onPressed: () {
              myHomePageState.openModal(myHomePageState.getEmptyTask());
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              minimumSize: const Size(50.0, 50.0),
              backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
              shape: const ContinuousRectangleBorder(
                side: BorderSide(
                  width: 2.0
                ),
              ),
            ),
            child: const Text('+'),
          ),
        ],
      ),
    );
  }
}
