import 'package:modulo_17_todo_list/app/models/task_model.dart';

abstract class TasksRepository {

  Future<void> save(DateTime date, String description);

  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end);
}