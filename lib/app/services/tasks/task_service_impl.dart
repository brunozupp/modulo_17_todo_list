import 'package:modulo_17_todo_list/app/models/task_model.dart';
import 'package:modulo_17_todo_list/app/models/week_task_model.dart';
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

  @override
  Future<List<TaskModel>> getToday() async {
    return await _tasksRepository.findByPeriod(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() async {
    final tomorrowDate = DateTime.now().add(const Duration(days: 1));

    return await _tasksRepository.findByPeriod(tomorrowDate, tomorrowDate);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    
    final today = DateTime.now();
    
    var startFilter = DateTime(today.year, today.month, today.day, 0, 0, 0);

    DateTime? endFilter;

    if(startFilter.weekday != DateTime.monday) {
      startFilter = startFilter.subtract(Duration(days: (startFilter.weekday - 1)));
    }

    endFilter = startFilter.add(const Duration(days: 7));

    final tasks = await _tasksRepository.findByPeriod(startFilter, endFilter);

    return WeekTaskModel(
      startDate: startFilter, 
      endDate: endFilter, 
      tasks: tasks
    );
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) async {
    await _tasksRepository.checkOrUncheckTask(task);
  }
}
