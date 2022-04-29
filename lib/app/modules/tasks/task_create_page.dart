import 'package:flutter/material.dart';
import 'package:modulo_17_todo_list/app/core/ui/theme_extensions.dart';
import 'package:modulo_17_todo_list/app/core/widgets/todo_list_field.dart';

import 'package:modulo_17_todo_list/app/modules/tasks/task_create_controller.dart';
import 'package:modulo_17_todo_list/app/modules/tasks/widgets/calendar_button.dart';
import 'package:validatorless/validatorless.dart';

class TaskCreatePage extends StatelessWidget {

  final TaskCreateController _controller;

  TaskCreatePage({
    Key? key,
    required TaskCreateController controller,
  }) :
    _controller = controller, 
    super(key: key);

  final descriptionEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, 
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: context.primaryColor,
        onPressed: () {

        }, 
        label: const Text(
          "Salvar Task",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Criar Atividade",
                  style: context.titleStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TodoListField(
                label: '',
                controller: descriptionEC,
                validator: Validatorless.required("Descrição é obrigatória"),
              ),
              const SizedBox(
                height: 20,
              ),
              CalendarButton(),
            ],
          ),
        ),
      ),
    );
  }
}
