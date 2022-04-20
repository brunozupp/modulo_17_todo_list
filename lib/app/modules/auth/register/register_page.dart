import 'package:flutter/material.dart';
import 'package:modulo_17_todo_list/app/core/notifier/default_listener_notifier.dart';
import 'package:modulo_17_todo_list/app/core/ui/theme_extensions.dart';
import 'package:modulo_17_todo_list/app/core/validators/validators.dart';
import 'package:modulo_17_todo_list/app/core/widgets/todo_list_field.dart';
import 'package:modulo_17_todo_list/app/core/widgets/todo_list_logo.dart';
import 'package:modulo_17_todo_list/app/modules/auth/register/register_controller.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void initState() {
    super.initState();

    final defaultListener = DefaultListenerNotifier(
      changeNotifier: context.read<RegisterController>(),
    );

    defaultListener.listener(
      context: context,
      successCallback: (notifier, listenerInstance) {
        listenerInstance.dispose();
        Navigator.of(context).pop();
      }
    );

  }

  @override
  void dispose() {

    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();

    

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Todo List",
              style: TextStyle(
                fontSize: 10,
                color: context.primaryColor,
              ),
            ),
            Text(
              "Cadastro",
              style: TextStyle(
                fontSize: 15,
                color: context.primaryColor,
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(), 
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 20,
                color: context.primaryColor,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * .5,
            child: const FittedBox(
              child: TodoListLogo(),
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TodoListField(
                    controller: _emailEC,
                    label: "Email",
                    validator: Validatorless.multiple([
                      Validatorless.required("Email obrigatório"),
                      Validatorless.email("Email inválido"),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TodoListField(
                    controller: _passwordEC,
                    label: "Senha",
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required("Senha obrigatória"),
                      Validatorless.min(6, "Senha deve ter pelo menos 6 caracteres"),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TodoListField(
                    controller: _confirmPasswordEC,
                    label: "Confirma Senha",
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required("Confirma senha obrigatória"),
                      Validators.compare(_passwordEC, "Senha diferente de confirma senha"),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () async {

                        final formValid = _formKey.currentState?.validate() ?? false;

                        if(formValid) {

                          final email = _emailEC.text;
                          final password = _passwordEC.text;

                          await context.read<RegisterController>().registerUser(email, password);
                        }
                      }, 
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Login",
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}