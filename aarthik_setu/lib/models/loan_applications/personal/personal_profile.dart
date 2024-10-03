class PersonalProfile {
  final String? id;
  final String userId;
  final String name;
  final String pan;

  PersonalProfile({
    this.id,
    required this.userId,
    required this.name,
    required this.pan,
  });

  factory PersonalProfile.fromJson(Map<String, dynamic> json) {
    return PersonalProfile(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      pan: json['pan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'pan': pan,
    };
  }
}
