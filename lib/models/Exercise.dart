class Exercise {
  final String id;
  final String name;
  final String image;
  final String days;
  final String exerciseCount;

  Exercise({
    required this.id,
    required this.name,
    required this.image,
    required this.days,
    required this.exerciseCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'days': days,
      'exerciseCount': exerciseCount,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map, String documentId) {
    return Exercise(
      id: documentId,
      name: map['name'] as String,
      image: map['image'] as String,
      days: map['days'] as String,
      exerciseCount: map['exerciseCount'] as String,
    );
  }
}
