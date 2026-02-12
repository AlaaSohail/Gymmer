class Trainer {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final String specialization;
  final String gender;

  Trainer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.specialization,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'specialization': specialization,
      'gender': gender,
    };
  }

  factory Trainer.fromMap(Map<String, dynamic> map, String documentId) {
    return Trainer(
      id: documentId,
      name: (map['name'] as String?) ?? '',
      email: (map['email'] as String?) ?? '',
      phone: (map['phone'] as String?) ?? '',
      image: (map['image'] as String?) ?? 'profile.png',
      specialization: (map['specialization'] as String?) ?? '',
      gender: (map['gender'] as String?) ?? '',
    );
  }

}
