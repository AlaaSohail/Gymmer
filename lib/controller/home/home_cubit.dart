// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/Exercise.dart';
import '../../services/home_services.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getHomeContect() async {
    emit(HomeLoading());

    try {
      final exercise = await homeServices.getExercises();
      // final saleProducts = await homeServices.getSaleProducts();
      emit(HomeSuccess(exercise: exercise));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  final homeServices = HomeServicesImpl();
}
