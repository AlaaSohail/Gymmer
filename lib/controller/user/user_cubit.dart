import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

import '../../models/user_data.dart';
import '../../services/auth_services.dart';
import '../../services/user_services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  final authServices = AuthServicesImpl();

  final userServices = UserServicesImpl();

  Future<String> uploadProfileImage(File file) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final ref = FirebaseStorage.instance.ref().child('users/$uid/profile.jpg');

    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> loadCurrentUser() async {
    emit(UserLoading());
    try {
      final user = await userServices.currentUserStream();
      emit(UserSuccess(user));
    } catch (e, s) {
      print("USER ERROR: $e");
      print(s);
      emit(UserError(e.toString()));
    }
  }

  Future<void> updateCurrentUser(UserData user) async {
    emit(UserLoading());

    try {
      await userServices.setUserData(user);
      emit(UserSuccess(user));

      await loadCurrentUser();
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
