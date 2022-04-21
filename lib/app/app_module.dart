import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modulo_17_todo_list/app/app_widget.dart';
import 'package:modulo_17_todo_list/app/core/auth/auth_provider.dart';
import 'package:modulo_17_todo_list/app/core/database/sqlite_connection_factory.dart';
import 'package:modulo_17_todo_list/app/repositories/user/user_repository.dart';
import 'package:modulo_17_todo_list/app/repositories/user/user_repository_impl.dart';
import 'package:modulo_17_todo_list/app/services/user/user_service.dart';
import 'package:modulo_17_todo_list/app/services/user/user_service_impl.dart';
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
          create: (_) => FirebaseAuth.instance,
        ),
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false, // No momento que cair no AppModule, já vai criar a instância, não vai esperar o objeto ser usado numa primeira vez pra criar
        ),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(
            firebaseAuth: context.read(),
          ),
        ),
        Provider<UserService>(
          create: (context) => UserServiceImpl(
            userRepository: context.read(),
          ),
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (context) => AuthProvider(
            firebaseAuth: context.read(), 
            userService: context.read(),
          )..loadListener(),
        ),
      ],
      child: const AppWidget(),
    );
  }
}