import 'package:firebase_auth/firebase_auth.dart';

import 'package:modulo_17_todo_list/app/repositories/user/user_repository.dart';
import 'package:modulo_17_todo_list/app/services/user/user_service.dart';

class UserServiceImpl implements UserService {

  final UserRepository _userRepository;

  UserServiceImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;
  
  @override
  Future<User?> register(String email, String password) async {
    return await _userRepository.register(email, password);
  }

  @override
  Future<User?> login(String email, String password) async {
    return await _userRepository.login(email, password);
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _userRepository.forgotPassoword(email);
  }

  @override
  Future<User?> googleLogin() async {
    return await _userRepository.googleLogin();
  }

  @override
  Future<void> googleLogout() async {
    await _userRepository.googleLogout();
  }
  
}
