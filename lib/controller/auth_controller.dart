import 'package:flutter/material.dart';
import '../models/constsOfDart.dart';
import '../models/user_data.dart';
import '../services/auth.dart';
import 'database_controller.dart';

class AuthController with ChangeNotifier {
  final AuthBase auth;
  String email;
  String password;
  String name;

  Database database = FirestoreDatabase('123');

  AuthController({
    required this.auth,
    this.email = '',
    this.password = '',
    this.name = '',
  });

  void updateEmail(String email) => copyWith(email: email);

  void updatePassword(String password) => copyWith(password: password);

  void updateName(String name) => copyWith(name: name);

  Future<void> submit() async {
    try {
      await auth.loginWithEmailAndPassword(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signup() async {
    try {
      final user = await auth.signupWithEmailAndPassword(email, password);
      await database.setUserData(
        UserData(
          uid: user?.uid ?? documentIDFromLocalData(),
          email: email,
          name: name,
          phone: '',
          image: '',
          gender: '',
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  void copyWith({String? email, String? password, String? name}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.name = name ?? this.name;
    notifyListeners();
  }
}
