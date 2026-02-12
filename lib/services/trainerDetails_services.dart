import 'package:gymmer/controller/trainer/trainer_cubit.dart';
import 'package:gymmer/models/Link.dart';

import '../models/Trainer.dart';
import '../models/ApiPath.dart';
import 'firestore_services.dart';

abstract class TrainerServices {
  Future<Trainer> getTrainer(String TrainerId);

  Future<List<Link>> getTrainerLinks(String trianerId);
}

class TrainerServicesImpl implements TrainerServices {
  final fireStore = FireStoreServices.instance;

  @override
  Future<Trainer> getTrainer(String tId) async => await fireStore.getDocument(
    path: ApiPath.trainer(tId),
    builder: (data, documentId) => Trainer.fromMap(data, documentId),
  );

  @override
  Future<List<Link>> getTrainerLinks(String trianerId) async {
    return fireStore.getCollection(
      path: ApiPath.trainerLinks(trianerId),
      builder: (data, documentId) => Link.fromMap(data, documentId),
    );
  }
}
