import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthenticationLogin {
  final FirebaseAuth fireBaseAuth = FirebaseAuth.instance;
  void signUp(String email, String pass, String name, String phone,
      Function onSuccess, Function(String) onRegisterError) {
    fireBaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      debugPrint(user.toString());
      createUser(user.user!.uid, name, phone, onSuccess, onRegisterError);
    }).catchError((err) {
      debugPrint("err: $err.toString()");
      onSignUpErr(err.code, onRegisterError);
    });
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    fireBaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      onSuccess();
    }).catchError((err) {
      debugPrint("err: $err.toString()");
      onSignInError("Sign-In fail, please try again");
    });
  }

  createUser(String userId, String name, String phone, Function onSuccess,
      Function(String) onRegisterError) {
    var user = <String, String>{};
    user["name"] = name;
    user["phone"] = phone;
    // ignore: deprecated_member_use
    var ref = FirebaseDatabase.instance.ref().child("users");
    ref.child(userId).set(user).then((vl) {
      debugPrint("on value: SUCCESSED");
      onSuccess();
    }).catchError((err) {
      debugPrint("err: $err.toString()");
      onRegisterError("SignUp fail, please try again");
    }).whenComplete(() {
      debugPrint("completed");
    });
  }

  void onSignUpErr(String code, Function(String) onRegisterError) {
    debugPrint(code);
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError("Invalid email");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError("Email has existed");
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterError("The password is not strong enough");
        break;
      default:
        onRegisterError("SignUp fail, please try again");
        break;
    }
  }

  Future<void> signOut() async {
    debugPrint("signOut");
    return fireBaseAuth.signOut();
  }
}
