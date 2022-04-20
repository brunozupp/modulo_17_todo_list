import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:modulo_17_todo_list/app/core/notifier/default_listener_notifier.dart';
import 'package:modulo_17_todo_list/app/core/widgets/todo_list_field.dart';
import 'package:modulo_17_todo_list/app/core/widgets/todo_list_logo.dart';
import 'package:modulo_17_todo_list/app/modules/auth/login/login_controller.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';
    
class LoginPage extends StatefulWidget {

  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void initState() {
    super.initState();

    DefaultListenerNotifier(
      changeNotifier: context.read<LoginController>(),
    ).listener(
      context: context, 
      successCallback: (notifier, listenerNotifier) {
        listenerNotifier.dispose();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const TodoListLogo(),

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
                                Validatorless.min(6, "Senha deve conter pelo menos 6 caracteres"),
                              ]),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {

                                  }, 
                                  child: const Text(
                                    "Esqueceu sua senha?",
                                  ),
                                ),

                                ElevatedButton(
                                  onPressed: () async {

                                    final formValid = _formKey.currentState?.validate() ?? false;

                                    final email = _emailEC.text;
                                    final password = _passwordEC.text;

                                    if(formValid) {
                                      context.read<LoginController>().login(email, password);
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
                              ],
                            ),
                          ],
                        )
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F3F7),
                          border: Border(
                            top: BorderSide(
                              width: 2,
                              color: Colors.grey.withAlpha(50),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            SignInButton(
                              Buttons.Google,
                              text: "Continue com o Google",
                              padding: const EdgeInsets.all(5),
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              onPressed: () {
                                
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Não tem conta?",
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed("/register");
                                  }, 
                                  child: const Text("Cadastre-se"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}