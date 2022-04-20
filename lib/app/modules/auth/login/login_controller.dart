import 'package:flutter/material.dart';
import 'package:modulo_17_todo_list/app/core/notifier/default_change_notifier.dart';
import 'package:modulo_17_todo_list/app/exceptions/auth_exception.dart';
import 'package:modulo_17_todo_list/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {

  final UserService _userService;

  LoginController({
    required UserService userService,
  }) : _userService = userService;

  Future<void> login(String email, String password) async {

    try {
      showLoadingAndResetState();
      
      notifyListeners();
      
      final user = await _userService.login(email, password);

      if(user != null) {
        success();
      } else {
        setError("Usuário e/ou senha inválidos");
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}