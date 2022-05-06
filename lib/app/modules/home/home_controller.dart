import 'package:modulo_17_todo_list/app/core/auth/auth_provider.dart';
import 'package:modulo_17_todo_list/app/core/notifier/default_change_notifier.dart';
import 'package:modulo_17_todo_list/app/models/task_filter_enum.dart';
import 'package:modulo_17_todo_list/app/models/task_model.dart';
import 'package:modulo_17_todo_list/app/models/total_tasks_model.dart';
import 'package:modulo_17_todo_list/app/models/week_task_model.dart';
import 'package:modulo_17_todo_list/app/services/tasks/task_service.dart';

class HomeController extends DefaultChangeNotifier {

  final TasksService _tasksService;
  final AuthProvider _authProvider;
  
  HomeController({
    required TasksService tasksService,
    required AuthProvider authProvider,
  }) : 
  _tasksService = tasksService,
  _authProvider = authProvider;

  var filterSelected = TaskFilterEnum.today;

  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;

  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];

  DateTime? initialDateOfWeek;
  DateTime? selectedDay;

  bool showFinishedTasks = false;

  Future<void> loadTotalTasks() async {

    final userId = _authProvider.user!.uid;

    final allTasks = await Future.wait([
      _tasksService.getToday(userId),
      _tasksService.getTomorrow(userId),
      _tasksService.getWeek(userId),
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

  Future<void> findTasks({
    required TaskFilterEnum filter,
  }) async {
    
    filterSelected = filter;

    showLoading();

    notifyListeners();

    List<TaskModel> tasks;

    final userId = _authProvider.user!.uid;

    switch(filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday(userId);
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getTomorrow(userId);
        break;
      case TaskFilterEnum.week:
        final weekModel = await _tasksService.getWeek(userId);
        initialDateOfWeek = weekModel.startDate;
        tasks = weekModel.tasks;
        break;
    }

    filteredTasks = tasks;
    allTasks = tasks;

    if(filter == TaskFilterEnum.week) {
      if(selectedDay != null) {
        await filterByDay(selectedDay!);
      } else if(initialDateOfWeek != null) {
        await filterByDay(initialDateOfWeek!);
      }
    } else {
      selectedDay = null;
    }

    if(!showFinishedTasks) {
      filteredTasks = filteredTasks.where((task) => !task.finished).toList();
    }

    hideLoading();

    notifyListeners();
  }

  Future<void> filterByDay(DateTime date) async {
    selectedDay = date;

    filteredTasks = allTasks.where((task) {
      return _isSameDate(task.dateTime, date);
    }).toList();

    if(!showFinishedTasks) {
      filteredTasks = filteredTasks.where((task) => !task.finished).toList();
    }

    notifyListeners();
  }

  bool _isSameDate(DateTime d1, DateTime d2) {
    return d1.day == d2.day && d1.month == d2.month && d1.year == d2.year;
  }

  Future<void> refreshPage() async {
    await findTasks(filter: filterSelected);
    await loadTotalTasks();

    notifyListeners();
  }

  Future<void> checkOrUnchekTask(TaskModel task) async {
    
    showLoadingAndResetState();

    notifyListeners();

    final taskUpdate = task.copyWith(
      finished: !task.finished,
    );

    await _tasksService.checkOrUncheckTask(taskUpdate);

    hideLoading();

    refreshPage();
  }

  void showOrHideFinishedTasks() {
    showFinishedTasks = !showFinishedTasks;
    refreshPage();
  }

  Future<void> deleteTask(int id) async {

    showLoadingAndResetState();

    notifyListeners();

    await _tasksService.deleteTask(id);

    hideLoading();

    refreshPage();
  }
}
