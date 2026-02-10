import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Trainer.dart';
import '../../services/trainerDetails_services.dart';

part 'trainer_details_state.dart';

class TrainerDetailsCubit extends Cubit<TrainerDetailsState> {
  TrainerDetailsCubit() : super(TrainerDetailsInitial());

  final trainerDetailsServices = TrainerServicesImpl();

  Future<void> getTrainerDetails(String trainerId) async {
    emit(TrainerDetailsLoading());
    try {
      final trainer = await trainerDetailsServices.getTrainer(trainerId);
      emit(TrainerDetailsSuccess(trainer));
    } catch (e) {
      emit(TrainerDetailsError(e.toString()));
    }
  }

  void init(Trainer trainer) {
    emit(TrainerDetailsSuccess(trainer));
  }
}
