part of 'trainer_details_cubit.dart';

@immutable
sealed class TrainerDetailsState {}

final class TrainerDetailsInitial extends TrainerDetailsState {}

final class TrainerDetailsLoading extends TrainerDetailsState{}

final class TrainerDetailsSuccess extends TrainerDetailsState{

  final Trainer trainer;

  TrainerDetailsSuccess(this.trainer);

}

final class TrainerDetailsError extends TrainerDetailsState{
  final String message;

  TrainerDetailsError(this.message);
}
