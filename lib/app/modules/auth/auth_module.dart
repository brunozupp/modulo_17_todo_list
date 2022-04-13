import 'package:modulo_17_todo_list/app/core/modules/todo_list_module.dart';
import 'package:modulo_17_todo_list/app/modules/auth/login/login_controller.dart';
import 'package:modulo_17_todo_list/app/modules/auth/login/login_page.dart';
import 'package:provider/provider.dart';

class AuthModule extends TodoListModule {

  AuthModule() : super(
    bindings: [
      ChangeNotifierProvider(
        create: (_) => LoginController(),
      ),
    ],
    routers: {
      '/login': (context) => const LoginPage(),
    },
  );

}