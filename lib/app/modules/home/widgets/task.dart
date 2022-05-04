import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:modulo_17_todo_list/app/models/task_model.dart';

class Task extends StatelessWidget {

  final TaskModel task;

  Task({
    Key? key,
    required this.task,
  }) : super(key: key);

  final dateFormat = DateFormat("dd/MM/y");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          leading: Checkbox(
            value: task.finished, 
            onChanged: (value) {}
          ),
          title: Text(
            task.description,
            style: TextStyle(
              decoration: task.finished ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            dateFormat.format(task.dateTime),
            style: TextStyle(
              decoration: task.finished ? TextDecoration.lineThrough : null,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
