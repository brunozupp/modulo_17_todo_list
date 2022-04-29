import 'package:modulo_17_todo_list/app/core/notifier/default_change_notifier.dart';
import 'package:modulo_17_todo_list/app/services/tasks/task_service.dart';

class TaskCreateController extends DefaultChangeNotifier {
  
  final TasksService _tasksService;

  TaskCreateController({
    required TasksService tasksService,
  }) : 
    _tasksService = tasksService;

  DateTime? _selectedDate;

  set selectedDate(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;
}
