import 'package:modulo_17_todo_list/app/models/task_model.dart';
import 'package:modulo_17_todo_list/app/models/week_task_model.dart';

abstract class TasksService {

  Future<void> save({
    required DateTime date, 
    required String description,
    required String userId,
  });

  Future<List<TaskModel>> getToday(String userId);

  Future<List<TaskModel>> getTomorrow(String userId);

  Future<WeekTaskModel> getWeek(String userId);

  Future<void> checkOrUncheckTask(TaskModel task);
}