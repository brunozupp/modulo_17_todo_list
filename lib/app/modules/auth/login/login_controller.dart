import 'package:flutter/material.dart';
import 'package:modulo_17_todo_list/app/core/notifier/default_change_notifier.dart';
import 'package:modulo_17_todo_list/app/exceptions/auth_exception.dart';
import 'package:modulo_17_todo_list/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {

  final UserService _userService;

  String? infoMessage;

  LoginController({
    required UserService userService,
  }) : _userService = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> googleLogin() async {

    try {
      showLoadingAndResetState();
      
      notifyListeners();
      
      final user = await _userService.googleLogin();
      
      if(user != null) {
        success();
      } else {
        await _userService.googleLogout();
        setError("Erro ao realizar login com o Google");
      }
    } on AuthException catch (e) {
      await _userService.googleLogout();
      setError(e.message);

    } finally {
      hideLoading();
      notifyListeners();
    }
  }

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

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();

      notifyListeners();
      
      await _userService.forgotPassword(email);

      infoMessage = "Reset de senha enviado para seu email";

    } on AuthException catch (e) {
      setError(e.message);
    
    } on Exception {
      setError("Erro ao resetar a senha");
      
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  @override
  void showLoadingAndResetState() {
    super.showLoadingAndResetState();

    infoMessage = null;
  }
}