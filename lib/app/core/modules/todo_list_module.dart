import 'package:flutter/material.dart';
import 'package:modulo_17_todo_list/app/core/modules/todo_list_page.dart';
import 'package:provider/single_child_widget.dart';

abstract class TodoListModule {

  final Map<String, WidgetBuilder> _routers;
  final List<SingleChildWidget>? _bindings;

  TodoListModule({
    required Map<String, WidgetBuilder> routers,
    List<SingleChildWidget>? bindings,
  }) : _routers = routers, 
       _bindings = bindings;

  Map<String, WidgetBuilder> get routers => _routers.map((key, pageBuilder) {
    return MapEntry(key, (_) => TodoListPage(
      page: pageBuilder,
      bindings: _bindings,
    ));
  });

  Widget getPage(String path, BuildContext context) {

    final widgetBuilder = _routers[path];

    if(widgetBuilder != null) {
      return TodoListPage(
        page: widgetBuilder,
        bindings: _bindings,
      );
    }

    throw Exception();
  }
}