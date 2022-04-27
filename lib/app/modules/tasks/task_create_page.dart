import 'package:flutter/material.dart';

import 'package:modulo_17_todo_list/app/modules/tasks/task_create_controller.dart';

class TaskCreatePage extends StatelessWidget {

  final TaskCreateController _controller;

  const TaskCreatePage({
    Key? key,
    required TaskCreateController controller,
  }) :
    _controller = controller, 
    super(key: key);

   @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
      ),
      body: Container(),
    );
  }
}
