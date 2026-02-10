part of 'trainer_cubit.dart';

@immutable
sealed class TrainerState {}

final class TrainerInitial extends TrainerState {}

final class TrainerLoading extends TrainerState {}

final class TrainerSuccess extends TrainerState {
  final List<Trainer> trainers;

  TrainerSuccess(this.trainers);
}

final class TrainerError extends TrainerState {
  final String message;

  TrainerError(this.message);
}
