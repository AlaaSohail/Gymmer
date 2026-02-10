import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_data.dart';
import '../../services/auth_services.dart';
import '../../services/firestore_services.dart';
import '../../services/user_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final authServices = AuthServicesImpl();
  final fireStoreServices = FireStoreServices.instance;
  final userServices = UserServicesImpl();

  String? name;
  String? phone;
  String? image;
  String? gender;

  Future<void> Login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authServices.loginWithEmailAndPassword(
        email,
        password,
      );
      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthError("Something went wrong"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> Signup(String email, String password, String name) async {
    emit(AuthLoading());
    try {
      final user = await authServices.signupWithEmailAndPassword(
        email,
        password,
      );

      if (user != null) {
        await userServices.setUserData(
          UserData(
            uid: user.uid,
            email: email,
            name: name,
            phone: '0598805969',
            image: 'me.png',
            gender: 'Male',
          ),
        );
        emit(AuthSuccess());
      } else {
        emit(AuthError("Something went wrong"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> authStatus() async {
    final user = authServices.currentUser;

    if (user != null) {
      emit(AuthSuccess());
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await authServices.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }


}
