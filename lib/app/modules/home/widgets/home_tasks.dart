import 'package:flutter/material.dart';
import 'package:modulo_17_todo_list/app/core/ui/theme_extensions.dart';
import 'package:modulo_17_todo_list/app/models/task_filter_enum.dart';
import 'package:modulo_17_todo_list/app/models/task_model.dart';
import 'package:modulo_17_todo_list/app/modules/home/home_controller.dart';
import 'package:modulo_17_todo_list/app/modules/home/widgets/task.dart';
import 'package:provider/provider.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Selector<HomeController,String>(
            selector: (context, controller) {
              return controller.filterSelected.description;
            },
            builder: (context,description,child) {
              return Text(
                "TASKS $description",
                style: context.titleStyle,
              );
            }, 
          ),
          
          Column(
            children: context.select<HomeController, List<TaskModel>>((controller) {
              return controller.filteredTasks;
            }).map((task) => Task(
              task: task,
            )).toList(),
          ),
        ],
      ),
    );
  }
}