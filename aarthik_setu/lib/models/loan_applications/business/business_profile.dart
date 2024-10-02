class BusinessProfile {
  final String? id;
  final String userId;
  final String name;
  final String pan;

  BusinessProfile({
    this.id,
    required this.userId,
    required this.name,
    required this.pan,
  });

  factory BusinessProfile.fromJson(Map<String, dynamic> json) {
    return BusinessProfile(
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
