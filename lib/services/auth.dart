import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User? get currentUser;

  Stream<User?> authStateChanges();

  Future<User?> loginWithEmailAndPassword(String email, String password);

  Future<User?> signupWithEmailAndPassword(String email, String password);

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    final auth_user = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return auth_user.user;
  }

  @override
  Future<User?> signupWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final auth_user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return auth_user.user;
  }

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  Future<void> signOut() async => await _firebaseAuth.signOut();
}
