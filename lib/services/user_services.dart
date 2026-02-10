
import '../models/api_path.dart';
import '../models/user_data.dart';
import 'auth.dart';
import 'firestore_services.dart';

abstract class UserServices {
  Future<UserData> currentUserStream();

  Future<void> setUserData(UserData userData);

}

class UserServicesImpl implements UserServices {
  final FireStoreServices _services = FireStoreServices.instance;
  final authServices = Auth();

  @override
  Future<UserData> currentUserStream() async => await _services.getDocument(
    path: 'users/${authServices.currentUser!.uid}',
    builder: (data, documentId) => UserData.fromMap(data, documentId),
  );

  @override
  Future<void> setUserData(UserData userData) async => await _services.setData(
    path: ApiPath.users(userData.uid),
    data: userData.toMap(),
  );


}
