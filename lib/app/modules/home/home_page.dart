import 'package:flutter/material.dart';
import 'package:modulo_17_todo_list/app/core/auth/auth_provider.dart';
import 'package:modulo_17_todo_list/app/core/ui/theme_extensions.dart';
import 'package:modulo_17_todo_list/app/core/ui/todo_list_icons.dart';
import 'package:modulo_17_todo_list/app/modules/home/widgets/home_filters.dart';
import 'package:modulo_17_todo_list/app/modules/home/widgets/home_header.dart';
import 'package:modulo_17_todo_list/app/modules/home/widgets/home_tasks.dart';
import 'package:modulo_17_todo_list/app/modules/home/widgets/home_week_filter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  const HomePage({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: context.primaryColor,
        ),
        backgroundColor: const Color(0xFFFAFBFE),
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: const Icon(
              TodoListIcons.filter,
            ),
            itemBuilder: (_) => <PopupMenuItem<bool>>[
              const PopupMenuItem<bool>(
                child: Text(
                  "Mostrar tarefas concluidas",
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
        backgroundColor: context.primaryColor,
      ),
      backgroundColor: const Color(0xFFFAFBFE),
      drawer: const HomePage(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeHeader(),
                      HomeFilters(),
                      HomeWeekFilter(),
                      HomeTasks(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}