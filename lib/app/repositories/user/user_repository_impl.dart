import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:modulo_17_todo_list/app/exceptions/auth_exception.dart';

import 'package:modulo_17_todo_list/app/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      
      log(e.message ?? "Erro FirebaseAuthException", stackTrace: s);

      if(e.code == "email-already-exists") {

        final loginTypes = await _firebaseAuth.fetchSignInMethodsForEmail(email);

        if(loginTypes.contains("password")) {
          throw AuthException(message: "Email já utilizado, por favor escolha outro email");
        } else {
          throw AuthException(message: "Você se cadastrou no TodoList pelo Google, por favor utilize ele para entrar");
        }
      } else {
        throw AuthException(message: e.message ?? "Erro ao registrar usuário");
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      return userCredential.user;
    } on PlatformException catch (e,s) {

      log(e.message ?? "Erro PlatformException", stackTrace: s);

      throw AuthException(
        message: e.message ?? "Erro ao realizar login",
      );
      
    } on FirebaseAuthException catch(e,s) {

      log(e.message ?? "Erro FirebaseAuthException", stackTrace: s);

      throw AuthException(
        message: e.message ?? "Erro ao realizar login",
      );
    }
  }

  @override
  Future<void> forgotPassoword(String email) async {
    
    try {
      final loginMethods = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      
      if(loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if(loginMethods.contains("google")) {
        throw AuthException(
          message: "Cadastro realizado com o google, não pode ser resetado a senha",
        );
      } else {
        throw AuthException(
          message: "Email não encontrado",
        );
      }
    } on AuthException catch (e, s) {

      log(e.message, stackTrace: s);

      rethrow;
    } on PlatformException catch(e, s) {

      log(e.message ?? "Erro PlatformException", stackTrace: s);

      throw AuthException(message: "Erro ao resetar senha");

    } on FirebaseException catch(e, s) {

      log(e.message ?? "Erro FirebaseException", stackTrace: s);

      throw AuthException(message: "Erro ao resetar senha");
    }
  }
  
}
