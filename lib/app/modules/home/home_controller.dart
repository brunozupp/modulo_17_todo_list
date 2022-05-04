import 'package:modulo_17_todo_list/app/core/notifier/default_change_notifier.dart';
import 'package:modulo_17_todo_list/app/models/task_filter_enum.dart';
import 'package:modulo_17_todo_list/app/models/task_model.dart';
import 'package:modulo_17_todo_list/app/models/total_tasks_model.dart';
import 'package:modulo_17_todo_list/app/models/week_task_model.dart';
import 'package:modulo_17_todo_list/app/services/tasks/task_service.dart';

class HomeController extends DefaultChangeNotifier {

  final TasksService _tasksService;

  HomeController({
    required TasksService tasksService,
  }) : _tasksService = tasksService;

  var filterSelected = TaskFilterEnum.today;

  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek(),
    ]);

    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTask = allTasks[2] as WeekTaskModel;

    todayTotalTasks = TotalTasksModel(
      totalTasks: todayTasks.length, 
      totalTasksFinish: todayTasks.where((task) => task.finished).length,
    );

    tomorrowTotalTasks = TotalTasksModel(
      totalTasks: tomorrowTasks.length, 
      totalTasksFinish: tomorrowTasks.where((task) => task.finished).length,
    );

    weekTotalTasks = TotalTasksModel(
      totalTasks: weekTask.tasks.length, 
      totalTasksFinish: weekTask.tasks.where((task) => task.finished).length,
    );

    notifyListeners();
  }
}
