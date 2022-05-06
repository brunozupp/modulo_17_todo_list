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
  Future<void> save({
    required DateTime date, 
    required String description,
    required String userId,
  }) async {
    
    final conn = await _sqliteConnectionFactory.openConnection();

    await conn.insert("todo", {
      "id": null,
      "userId": userId,
      "descricao": description,
      "data_hora": date.toIso8601String(),
      "finalizado": 0,
    });
  }

  @override
  Future<List<TaskModel>> findByPeriod({
    required DateTime start, 
    required DateTime end,
    required String userId,
  }) async {
    
    final startDate = DateTime(start.year,start.month,start.day,0,0,0);
    final endDate = DateTime(end.year,end.month,end.day,23,59,59);

    final conn = await _sqliteConnectionFactory.openConnection();

    final result = await conn.rawQuery('''
      SELECT * FROM todo 
      WHERE 
        data_hora between ? AND ? 
        AND userId = ?
      ORDER BY data_hora
    ''', [
      startDate.toIso8601String(), 
      endDate.toIso8601String(),
      userId,
    ]);

    return result.map((e) => TaskModel.loadFromDB(e)).toList();
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) async {
    
    final conn = await _sqliteConnectionFactory.openConnection();

    final finished = task.finished ? 1 : 0;

    await conn.rawUpdate(
      "UPDATE todo SET finalizado = ? WHERE id = ?",
      [finished, task.id],
    );
  }

  @override
  Future<void> deleteTask(int id) async {
    
    final conn = await _sqliteConnectionFactory.openConnection();

    await conn.rawDelete(
      "DELETE FROM todo WHERE id = ?",
      [id],
    );
  }

}
