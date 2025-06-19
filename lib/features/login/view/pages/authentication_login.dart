import 'dart:async';
import 'package:my_app_flutter/core/utils/files.dart';
import 'package:my_app_flutter/features/login/view/pages/firebase_authentication.dart';
class AuthenticationLogin {
  var firebaseAuthenticationLogin = FirebaseAuthenticationLogin();
  StreamController nameController = StreamController();
  StreamController emailController = StreamController();
  StreamController passController = StreamController();
  StreamController phoneController = StreamController();
  Stream get nameStream => nameController.stream;
  Stream get emailStream => emailController.stream;
  Stream get passStream => passController.stream;
  Stream get phoneStream => phoneController.stream;
  bool isValidLogin(String email, String password) {
    if (email.isEmpty) {
      emailController.sink.addError(AppFiles.shared
          .language("please input your email", "please input your email"));
      return false;
    }
    emailController.sink.add("");
    if (password.length < 6) {
      passController.sink.addError(AppFiles.shared.language(
          "password must have over 5 characters",
          "password must have over 5 characters"));
      return false;
    }
    passController.sink.add("");
    return true;
  }

  bool isValidRegister(
      String name, String email, String password, String phone) {
    if (name.isEmpty) {
      nameController.sink.addError(AppFiles.shared
          .language("please input your name", "please input your name"));
      return false;
    }
    nameController.sink.add("");
    if (phone.isEmpty) {
      phoneController.sink.addError(AppFiles.shared
          .language("please input your phone", "please input your phone"));
      return false;
    }
    phoneController.sink.add("");

    if (email.isEmpty) {
      emailController.sink.addError(AppFiles.shared
          .language("please input your email", "please input your email"));
      return false;
    }
    emailController.sink.add("");

    if (password.length < 6) {
      passController.sink.addError(AppFiles.shared.language(
          "password must have over 5 characters",
          "password must have over 5 characters"));
      return false;
    }
    passController.sink.add("");
    return true;
  }

  void signUp(String email, String pass, String phone, String name,
      Function onSuccess, Function(String) onError) {
    firebaseAuthenticationLogin.signUp(email, pass, name, phone, onSuccess, onError);
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    firebaseAuthenticationLogin.signIn(email, pass, onSuccess, onSignInError);
  }

  void dispose() {
    nameController.close();
    emailController.close();
    passController.close();
    phoneController.close();
  }
}
