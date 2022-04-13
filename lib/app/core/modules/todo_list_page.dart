import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class TodoListPage extends StatelessWidget {

  final WidgetBuilder _page;
  final List<SingleChildWidget>? _bindings;

  const TodoListPage({
    Key? key,
    required WidgetBuilder page,
    List<SingleChildWidget>? bindings,
  }) : _page = page, 
       _bindings = bindings,
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _bindings ?? [Provider(create: (_) => Object())],
      child: Builder( // Builder para pegar o context atualizado com as implementações dos providers
        builder: (context) => _page(context),
      ),
    );
  }
}