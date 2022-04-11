import 'package:flutter/material.dart';
import 'package:modulo_17_todo_list/app/modules/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo List Provider",
      home: SplashPage(),
    );
  }
}