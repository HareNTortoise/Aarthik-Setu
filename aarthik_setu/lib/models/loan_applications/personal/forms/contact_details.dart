class ContactDetails {
  String? id;
  String profileId;
  DateTime timestamp;
  String applicationId;
  String premisesName;
  String streetName;
  String landmark;
  String country;
  String state;
  String city;
  String pinCode;
  String village;
  String district;
  String subDistrict;
  String typeOfResidence;
  DateTime residenceSince;

  ContactDetails({
    required this.premisesName,
    required this.streetName,
    required this.landmark,
    required this.country,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.village,
    required this.district,
    required this.subDistrict,
    required this.typeOfResidence,
    required this.residenceSince,
    required this.profileId,
    required this.timestamp,
    required this.applicationId,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'premisesName': premisesName,
      'streetName': streetName,
      'landmark': landmark,
      'country': country,
      'state': state,
      'city': city,
      'pinCode': pinCode,
      'village': village,
      'district': district,
      'subDistrict': subDistrict,
      'typeOfResidence': typeOfResidence,
      'residenceSince': residenceSince,
      'profileId': profileId,
      'timestamp': timestamp,
      'applicationId': applicationId,
      'id': id,
    };
  }

  factory ContactDetails.fromJson(Map<String, dynamic> json) {
    return ContactDetails(
      premisesName: json['premisesName'],
      streetName: json['streetName'],
      landmark: json['landmark'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      pinCode: json['pinCode'],
      village: json['village'],
      district: json['district'],
      subDistrict: json['subDistrict'],
      typeOfResidence: json['typeOfResidence'],
      residenceSince: json['residenceSince'],
      profileId: json['profileId'],
      timestamp: json['timestamp'],
      applicationId: json['applicationId'],
      id: json['id'],
    );
  }
}
