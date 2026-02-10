import '../models/Trainer.dart';
import '../models/api_path.dart';
import 'firestore_services.dart';

abstract class TrainerServices {
  Future<Trainer> getTrainer(String TrainerId);
}

class TrainerServicesImpl implements TrainerServices {
  final fireStore = FireStoreServices.instance;

  @override
  Future<Trainer> getTrainer(String tId) async => await fireStore.getDocument(
    path: ApiPath.trainer(tId),
    builder: (data, documentId) => Trainer.fromMap(data, documentId),
  );
}
