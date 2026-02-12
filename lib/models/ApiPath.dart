class ApiPath {
  static String exercises() => 'exercises/';

  static String exercise(String exerciseId) => 'exercises/$exerciseId';

  static String trainers() => 'trainers/';

  static String trainer(String trainerId) => 'trainers/$trainerId';

  static String users(String uid) => 'users/$uid';

  static String trainerLinks(String trainerId) =>
      'trainers/$trainerId/links/';
}
