class Link {
  String id;
  String? youtube;
  String? instagram;
  String? facebook;
  String? twitter;

  Link({
    required this.id,
    this.youtube,
    this.instagram,
    this.facebook,
    this.twitter,
  });

  Map<String, dynamic> toMap() {
    return {
      'youtube': youtube,
      'instagram': instagram,
      'facebook': facebook,
      'twitter': twitter,
    };
  }

  factory Link.fromMap(Map<String, dynamic> map, String documentId) {
    return Link(
      id: documentId,
      youtube: map['youtube'],
      instagram: map['instagram'],
      facebook: map['facebook'],
      twitter: map['twitter'],
    );
  }
}
