class UserData {
  final String uid;
  final String email;
  final String name;
  final String phone;
  final String? image;
  final String gender;

  UserData({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    this.image,
    required this.gender,
  });

  UserData copyWith({
    String? name,
    String? phone,
    String? image,
    String? gender,
  }) {
    return UserData(
      uid: uid,
      email: email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'image': image,
      'gender': gender,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map, String documentId) {
    return UserData(
      uid: documentId,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      image: map['image'],
      gender: map['gender'] ?? '',
    );
  }
}
