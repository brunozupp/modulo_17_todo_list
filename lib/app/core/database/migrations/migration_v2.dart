import 'package:modulo_17_todo_list/app/core/database/migrations/migration.dart';
import 'package:sqflite_common/sqlite_api.dart';

class MigrationV2 implements Migration {

  @override
  void create(Batch batch) {
    batch.execute("CREATE TABLE teste(id integer)");
  }

  @override
  void update(Batch batch) {
    batch.execute("CREATE TABLE teste(id integer)");
  }

}