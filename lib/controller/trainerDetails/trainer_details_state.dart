part of 'trainer_details_cubit.dart';

@immutable
sealed class TrainerDetailsState {}

final class TrainerDetailsInitial extends TrainerDetailsState {}

final class TrainerDetailsLoading extends TrainerDetailsState {}

final class TrainerDetailsSuccess extends TrainerDetailsState {
  final Trainer trainer;

  TrainerDetailsSuccess(this.trainer);
}

final class TrainerDetailsError extends TrainerDetailsState {
  final String message;

  TrainerDetailsError(this.message);
}

final class TrainerLinksLoading extends TrainerDetailsState {}

final class TrainerLinksSuccess extends TrainerDetailsState {
  final List<Link> links;

  TrainerLinksSuccess(this.links);
}

final class TrainerLinksError extends TrainerDetailsState {
  final String message;

  TrainerLinksError(this.message);
}
