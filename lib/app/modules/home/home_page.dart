import 'package:flutter/material.dart';

import 'package:modulo_17_todo_list/app/core/ui/theme_extensions.dart';
import 'package:modulo_17_todo_list/app/core/ui/todo_list_icons.dart';
import 'package:modulo_17_todo_list/app/modules/home/home_controller.dart';
import 'package:modulo_17_todo_list/app/modules/home/widgets/home_drawer.dart';
import 'package:modulo_17_todo_list/app/modules/home/widgets/home_filters.dart';
import 'package:modulo_17_todo_list/app/modules/home/widgets/home_header.dart';
import 'package:modulo_17_todo_list/app/modules/home/widgets/home_tasks.dart';
import 'package:modulo_17_todo_list/app/modules/home/widgets/home_week_filter.dart';
import 'package:modulo_17_todo_list/app/modules/tasks/tasks_module.dart';

class HomePage extends StatefulWidget {

  final HomeController _homeController;

  const HomePage({
    Key? key,
    required HomeController homeController,
  }) : 
  _homeController = homeController,
  super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

    widget._homeController.loadTotalTasks();
  }

  void _goToCreateTask(BuildContext context) {

    // Fazendo desse jeito pois quero uma navegação com uma animação diferente
    Navigator.of(context).push(
      //MaterialPageRoute(builder: (_) => TaskModule().getPage("/task/create", context)),
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return TaskModule().getPage("/task/create", context);
        },
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(parent: animation, curve: Curves.easeInQuad);

          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          );
        }
      ),
    );
  }

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
        onPressed: () => _goToCreateTask(context),
        child: Icon(
          Icons.add,
        ),
        backgroundColor: context.primaryColor,
      ),
      backgroundColor: const Color(0xFFFAFBFE),
      drawer: HomeDrawer(),
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