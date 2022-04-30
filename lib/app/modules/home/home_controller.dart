import 'package:modulo_17_todo_list/app/core/notifier/default_change_notifier.dart';
import 'package:modulo_17_todo_list/app/models/task_filter_enum.dart';

class HomeController extends DefaultChangeNotifier {

  var filterSelected = TaskFilterEnum.today; 
}