import 'package:bloc/bloc.dart';
import 'package:gymmer/services/trainer_services.dart';
import 'package:meta/meta.dart';

import '../../models/Trainer.dart';

part 'trainer_state.dart';

class TrainerCubit extends Cubit<TrainerState> {
  TrainerCubit() : super(TrainerInitial());

  Future<void> getTrainers() async {
    emit(TrainerLoading());
    try {
      final trainer = await trainerServices.getTrainer();
      emit(TrainerSuccess(trainer));
    } catch (e) {
      emit(TrainerError(e.toString()));
    }
  }

  final trainerServices = TrainerServicesImpl();
}
