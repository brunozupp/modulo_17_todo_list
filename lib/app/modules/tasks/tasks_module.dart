import 'package:modulo_17_todo_list/app/core/modules/todo_list_module.dart';
import 'package:modulo_17_todo_list/app/modules/tasks/task_create_controller.dart';
import 'package:modulo_17_todo_list/app/modules/tasks/task_create_page.dart';
import 'package:modulo_17_todo_list/app/repositories/tasks/tasks_repository_impl.dart';
import 'package:modulo_17_todo_list/app/services/tasks/task_service_impl.dart';
import 'package:provider/provider.dart';

class TaskModule extends TodoListModule {

  TaskModule() : super(
    bindings: [
      Provider(
        create: (context) => TasksRepositoryImpl(
          sqliteConnectionFactory: context.read(),
        ),
      ),
      Provider(
        create: (context) => TasksServiceImpl(
          tasksRepository: context.read(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => TaskCreateController(
          tasksService: context.read(),
        ),
      ),
    ],
    routers: {
      "/task/create": (context) => TaskCreatePage(
        controller: context.read(),
      ),
    }
  );
}