import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:modulo_17_todo_list/app/core/database/sqlite_adm_connection.dart';
import 'package:modulo_17_todo_list/app/core/navigator/todo_list_navigator.dart';
import 'package:modulo_17_todo_list/app/core/ui/todo_list_ui_config.dart';
import 'package:modulo_17_todo_list/app/modules/auth/auth_module.dart';
import 'package:modulo_17_todo_list/app/modules/home/home_module.dart';
import 'package:modulo_17_todo_list/app/modules/splash/splash_page.dart';
import 'package:modulo_17_todo_list/app/modules/tasks/tasks_module.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({ Key? key }) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {

  final sqliteAdmConnection = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();

    // Vai ficar observando a classe SqliteAdmConnection para ver quando fechar
    // a conexão com o banco de dados
    WidgetsBinding.instance?.addObserver(sqliteAdmConnection);
  }

  @override
  void dispose() {

    WidgetsBinding.instance?.removeObserver(sqliteAdmConnection);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: TodoListNavigator.navigatiorKey,
      title: "Todo List Provider",
      theme: TodoListUiConfig.theme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("pt", "BR"),
      ],
      routes: {
        ...HomeModule().routers,
        ...AuthModule().routers,
        ...TaskModule().routers,
      },
      home: const SplashPage(),
    );
  }
}