import 'package:modulo_17_todo_list/app/models/task_model.dart';

abstract class TasksRepository {

  Future<void> save({
    required DateTime date, 
    required String description,
    required String userId,
  });

  Future<List<TaskModel>> findByPeriod({
    required DateTime start, 
    required DateTime end,
    required String userId,
  });

  Future<void> checkOrUncheckTask(TaskModel task);
}