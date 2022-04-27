import 'package:modulo_17_todo_list/app/core/modules/todo_list_module.dart';
import 'package:modulo_17_todo_list/app/modules/tasks/task_create_controller.dart';
import 'package:modulo_17_todo_list/app/modules/tasks/task_create_page.dart';
import 'package:provider/provider.dart';

class TaskModule extends TodoListModule {

  TaskModule() : super(
    bindings: [
      ChangeNotifierProvider(
        create: (_) => TaskCreateController(),
      ),
    ],
    routers: {
      "/task/create": (context) => TaskCreatePage(
        controller: context.read(),
      ),
    }
  );
}