import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

    } on FirebaseAuthException catch(e, s) {

      log(e.message ?? "Erro FirebaseException", stackTrace: s);

      throw AuthException(message: "Erro ao resetar senha");
    }
  }

  @override
  Future<User?> googleLogin() async {

    List<String> loginMethods = [];
    
    try {
      final googleSignIn = GoogleSignIn();
      
      final googleUser = await googleSignIn.signIn();
      
      if(googleUser != null) {
        // Faço essa verificação para conferir se o usuário já é cadastrado no app com o email do google
        loginMethods.addAll(await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email));
      
        if(loginMethods.contains("password")) {
          throw AuthException(message: "Você utilizou esse email para cadastro no TodoList, caso tenha esquecido sua senha, por favor, clique no link 'Esqueceu sua senha?'");
        } else {
      
          final googleAuth = await googleUser.authentication;
      
          final firebaseCredential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
      
          var userCredencial = await _firebaseAuth.signInWithCredential(firebaseCredential);
      
          return userCredencial.user;
        }
      } else {
        throw AuthException(message: "Não foi possível completar a obtenção do usuário do google");
      }
    } on AuthException catch(e,s) {
      log("Erro AuthException", stackTrace: s);
      rethrow;

    } on FirebaseAuthException catch (e, s) {
      log("Erro FirebaseAuthException", stackTrace: s);

      // Na prática, o Firebase só aceita que o cara use uma única credencial. Por exemplo,
      // o cara acessou o app anteriormente com a credencial do Facebook, então tenta acessar
      // o app pela credencial do Google. Aí vai dar erro.
      if(e.code == "account-exists-with-different-credential") {

        throw AuthException(message: '''
          Login inválido. Você se registrou no TodoList com os seguintes provedores: 
          ${loginMethods.join(",")}
        ''');
      } else {
        throw AuthException(message: "Erro ao realizar login com o Google");
      }
    } on PlatformException catch (e, s) {
      log("Erro PlatformException", stackTrace: s);

      throw AuthException(message: "Erro ao realizar login com o Google");
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async {
    
    final user = _firebaseAuth.currentUser;

    if(user != null) {
      await user.updateDisplayName(name);
      user.reload();
    }
  }
  
}
