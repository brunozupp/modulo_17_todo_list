import 'package:flutter/material.dart';
import 'package:modulo_17_todo_list/app/core/database/sqlite_connection_factory.dart';

// WidgetsBindingObserver - Vai observar o flutter como um todo
class SqliteAdmConnection with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    final connection = SqliteConnectionFactory();

    switch(state) {

      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        connection.closeConnection();
        break;
    }


    super.didChangeAppLifecycleState(state);
  }
}