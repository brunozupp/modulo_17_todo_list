import 'package:flutter/material.dart';
import 'package:modulo_17_todo_list/app/core/auth/auth_provider.dart';
import 'package:modulo_17_todo_list/app/core/ui/theme_extensions.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Selector<AuthProvider,String>(
        selector: (context, authProvider) {
          return authProvider.user?.displayName ?? "Não informado";
        },
        builder: (context,displayName,child) {
          return Text(
            "E ai, $displayName!",
            style: context.textTheme.headline5?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          );
        }
      ),
    );
  }
}