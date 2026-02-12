import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Link.dart';
import '../../models/Trainer.dart';
import '../../services/trainerDetails_services.dart';
import '../trainer/trainer_cubit.dart';

part 'trainer_details_state.dart';

class TrainerDetailsCubit extends Cubit<TrainerDetailsState> {
  TrainerDetailsCubit() : super(TrainerDetailsInitial());

  final trainerDetailsServices = TrainerServicesImpl();

  Future<void> getTrainerDetails(String trainerId) async {
    emit(TrainerDetailsLoading());
    try {
      final trainer = await trainerDetailsServices.getTrainer(trainerId);

      await getTrainerLinks(trainerId);

      emit(TrainerDetailsSuccess(trainer));
    } catch (e) {
      emit(TrainerDetailsError(e.toString()));
    }
  }

  void init(Trainer trainer) {
    emit(TrainerDetailsSuccess(trainer));
  }

  Future<void> getTrainerLinks(String trainerId) async {
    emit(TrainerLinksLoading());

    try {
      final links = await trainerDetailsServices.getTrainerLinks(trainerId);

      emit(TrainerLinksSuccess(links));
    } catch (e) {
      emit(TrainerDetailsError(e.toString()));
    }
  }
}
