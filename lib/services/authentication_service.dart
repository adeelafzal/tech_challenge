import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationService {
  Future<UserCredential> signInUser({
    required String email,
    required String password,
  });

  Future<UserCredential> signUpUser({
    required String email,
    required String password,
  });
}

class AuthenticationServiceImpl extends AuthenticationService {
  @override
  Future<UserCredential> signInUser(
      {required String email, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  @override
  Future<UserCredential> signUpUser({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }
}