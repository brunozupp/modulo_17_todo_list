import 'package:modulo_17_todo_list/app/core/database/sqlite_connection_factory.dart';
import 'package:modulo_17_todo_list/app/models/task_model.dart';
import 'package:modulo_17_todo_list/app/repositories/tasks/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {

  final SqliteConnectionFactory _sqliteConnectionFactory;

  TasksRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : 
    _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    
    final conn = await _sqliteConnectionFactory.openConnection();

    await conn.insert("todo", {
      "id": null,
      "descricao": description,
      "data_hora": date.toIso8601String(),
      "finalizado": 0,
    });
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    
    final startDate = DateTime(start.year,start.month,start.day,0,0,0);
    final endDate = DateTime(end.year,end.month,end.day,23,59,59);

    final conn = await _sqliteConnectionFactory.openConnection();

    final result = await conn.rawQuery('''
      SELECT * FROM todo
      WHERE data_hora between ? AND ?
      ORDER BY data_hora
    ''', [
      startDate.toIso8601String(), 
      endDate.toIso8601String()
    ]);

    return result.map((e) => TaskModel.loadFromDB(e)).toList();
  }

}
