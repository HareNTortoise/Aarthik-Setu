class Stakeholder {
  String relationshipType;
  double ownership;
  String salutation;
  String firstName;
  String? middleName;
  String lastName;
  String fatherName;
  String gender;
  DateTime dateOfBirth;
  String mobileNumber;
  String residenceStatus;
  String panNumber;
  String educationStatus;
  int totalExperience;
  String netWorth;

  String buildingNo;
  String street;
  String landmark;
  String pinCode;
  String village;
  String district;
  String subDistrict;
  String country;
  String state;
  String city;

  Stakeholder({
    required this.relationshipType,
    required this.ownership,
    required this.salutation,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.fatherName,
    required this.gender,
    required this.dateOfBirth,
    required this.mobileNumber,
    required this.residenceStatus,
    required this.panNumber,
    required this.educationStatus,
    required this.totalExperience,
    required this.netWorth,
    required this.buildingNo,
    required this.street,
    required this.landmark,
    required this.pinCode,
    required this.village,
    required this.district,
    required this.subDistrict,
    required this.country,
    required this.state,
    required this.city,
  });

  factory Stakeholder.fromJson(Map<String, dynamic> json) {
    return Stakeholder(
      relationshipType: json['relationshipType'],
      ownership: json['ownership'],
      salutation: json['salutation'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      fatherName: json['fatherName'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      mobileNumber: json['mobileNumber'],
      residenceStatus: json['residenceStatus'],
      panNumber: json['panNumber'],
      educationStatus: json['educationStatus'],
      totalExperience: json['totalExperience'],
      netWorth: json['netWorth'],
      buildingNo: json['buildingNo'],
      street: json['street'],
      landmark: json['landmark'],
      pinCode: json['pinCode'],
      village: json['village'],
      district: json['district'],
      subDistrict: json['subDistrict'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'relationshipType': relationshipType,
      'ownership': ownership,
      'salutation': salutation,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'fatherName': fatherName,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'mobileNumber': mobileNumber,
      'residenceStatus': residenceStatus,
      'panNumber': panNumber,
      'educationStatus': educationStatus,
      'totalExperience': totalExperience,
      'netWorth': netWorth,
      'buildingNo': buildingNo,
      'street': street,
      'landmark': landmark,
      'pinCode': pinCode,
      'village': village,
      'district': district,
      'subDistrict': subDistrict,
      'country': country,
      'state': state,
      'city': city,
    };
  }
}
