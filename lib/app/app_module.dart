import 'package:flutter/material.dart';
import 'package:modulo_17_todo_list/app/app_widget.dart';
import 'package:modulo_17_todo_list/app/core/database/sqlite_connection_factory.dart';
import 'package:provider/provider.dart';

/**
 * Vai ficar todas as configurações genéricas da aplicação.
 * Então tudo que for compartilhado dentro da aplicação vai ficar aqui dentro.
 * Esse cara é o core do sistema. Então aqui dentro vai ficar tudo que for
 * compartilhado entre os modulos.
 */
class AppModule extends StatelessWidget {
  const AppModule({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false, // No momento que cair no AppModule, já vai criar a instância, não vai esperar o objeto ser usado numa primeira vez pra criar
        ),
      ],
      child: const AppWidget(),
    );
  }
}