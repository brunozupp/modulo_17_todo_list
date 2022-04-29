import 'dart:developer';

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
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String description) async {

    showLoadingAndResetState();
    notifyListeners();

    try {
      if(_selectedDate != null) {
        await _tasksService.save(_selectedDate!, description);
        success();
      } else {
        setError("Data da task não selecionada");
      }
    } catch(e,s) {
      log(e.toString(), stackTrace: s);
      setError("Erro ao cadastrar task");
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
