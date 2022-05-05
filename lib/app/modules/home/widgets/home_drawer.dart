import 'package:flutter/material.dart';
import 'package:modulo_17_todo_list/app/core/auth/auth_provider.dart';
import 'package:modulo_17_todo_list/app/core/ui/messages.dart';
import 'package:modulo_17_todo_list/app/core/ui/theme_extensions.dart';
import 'package:modulo_17_todo_list/app/services/user/user_service.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {

  HomeDrawer({ Key? key }) : super(key: key);

  final nameVN = ValueNotifier<String>("");

   @override
   Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<AuthProvider, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ?? "https://w7.pngwing.com/pngs/223/244/png-transparent-computer-icons-avatar-user-profile-avatar-heroes-rectangle-black.png";
                  },
                  builder: (context, photoURL, child) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(photoURL),
                      radius: 30,
                    );
                  }
                ),
                
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Selector<AuthProvider, String>(
                      selector: (context, authProvider) {
                        if(authProvider.user?.displayName != null && authProvider.user!.displayName!.isNotEmpty) {
                          return authProvider.user!.displayName!;
                        }

                        return "Não informado";
                      },
                      builder: (context, displayName, child) {
                        return Text(
                          displayName,
                          style: context.textTheme.subtitle2,
                        );
                      }
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text("Alterar Nome"),
            onTap: () {
              showDialog(
                context: context, 
                builder: (_) {
                  return AlertDialog(
                    title: const Text("Alterar Nome"),
                    content: TextField(
                      onChanged: (value) => nameVN.value = value,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        }, 
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {

                          final nameValue = nameVN.value;

                          if(nameValue.isEmpty) {
                            Messages.of(context).showError("Nome obrigatório");
                          } else {

                            await context.read<UserService>().updateDisplayName(nameValue);

                            Navigator.of(context).pop();
                          }
                        }, 
                        child: const Text("Alterar"),
                      ),
                    ],
                  );
                }
              );
            },
          ),
          ListTile(
            title: const Text("Sair"),
            onTap: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
    );
  }
}