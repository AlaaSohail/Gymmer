import '../models/Exercise.dart';
import '../models/api_path.dart';
import 'firestore_services.dart';

abstract class HomeServices {
  // Future<List<Exercise>> getSaleProducts();

  Future<List<Exercise>> getExercises();
}

class HomeServicesImpl implements HomeServices {
  final fireStoreServices = FireStoreServices.instance;

  @override
  Future<List<Exercise>> getExercises() async =>
      await fireStoreServices.getCollection(
        path: ApiPath.exercises(),
        builder: (data, documentId) => Exercise.fromMap(data, documentId),
      );


}
