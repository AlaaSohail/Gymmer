// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Exercise.dart';
import '../models/api_path.dart';
import '../models/user_data.dart';
import '../services/firestore_services.dart';

abstract class Database {
  // Stream<List<Exercise>> saleProductsStream();
  //
  // Stream<List<Exercise>> newProductsStream();

  Stream<UserData> currentUserStream();

  Future<void> setUserData(UserData userData);
}

String get decumentId => DateTime.now().toIso8601String().toString();

class FirestoreDatabase implements Database {
  final _services = FireStoreServices.instance;
  final String uid;

  FirestoreDatabase(this.uid);

  // @override
  // Stream<List<Exercise>> saleProductsStream() => _services.collectionsStream(
  //   path: ApiPath.products(),
  //   builder: (data, documentId) => Exercise.fromMap(data!, documentId),
  //   queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0),
  // );
  //
  // @override
  // Stream<List<Exercise>> newProductsStream() => _services.collectionsStream(
  //   path: ApiPath.products(),
  //   builder: (data, documentId) => Exercise.fromMap(data!, documentId),
  // );

  Future<void> addProduct(Exercise product) async =>
      _services.setData(path: 'products/${decumentId}', data: product.toMap());

  Future<void> setProduct(Exercise product) async =>
      _services.setData(path: 'products/${product.id}', data: product.toMap());

  Future<void> deleteProduct(Exercise product) async =>
      _services.deleteData(path: 'products/${product.id}');

  @override
  Future<void> setUserData(UserData userData) async => await _services.setData(
    path: ApiPath.users(userData.uid),
    data: userData.toMap(),
  );

  @override
  Stream<UserData> currentUserStream() => _services.docStream(
    path: 'users/$uid',
    builder: (data, documentId) => UserData.fromMap(data!, documentId),
  );
}
