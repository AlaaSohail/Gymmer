import 'package:gymmer/models/ApiPath.dart';

import '../models/Trainer.dart';
import 'firestore_services.dart';

abstract class TrainerServices {
  Future<List<Trainer>> getTrainer();
}

class TrainerServicesImpl implements TrainerServices {
  final fireStore = FireStoreServices.instance;

  @override
  Future<List<Trainer>> getTrainer() async => await fireStore.getCollection(
    path: ApiPath.trainers(),
    builder: (data, documentId) => Trainer.fromMap(data, documentId),
  );
}
