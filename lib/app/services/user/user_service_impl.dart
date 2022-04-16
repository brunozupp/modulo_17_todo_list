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
  
}
