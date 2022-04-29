import 'package:modulo_17_todo_list/app/repositories/tasks/tasks_repository.dart';
import 'package:modulo_17_todo_list/app/services/tasks/task_service.dart';

class TasksServiceImpl implements TasksService {

  final TasksRepository _tasksRepository;

  TasksServiceImpl({
    required TasksRepository tasksRepository,
  }) : 
    _tasksRepository = tasksRepository;

  @override
  Future<void> save(DateTime date, String description) {
    return _tasksRepository.save(date, description);
  }



}
