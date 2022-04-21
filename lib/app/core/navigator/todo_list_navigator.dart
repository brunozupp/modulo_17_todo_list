import 'package:flutter/material.dart';

class TodoListNavigator {

  TodoListNavigator._();

    static final navigatiorKey = GlobalKey<NavigatorState>();

    static NavigatorState get to => navigatiorKey.currentState!;
}