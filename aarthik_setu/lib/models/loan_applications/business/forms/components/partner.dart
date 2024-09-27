class Partner {
  String relationType;
  double ownershipPercentage;
  String salutation;
  String firstName;
  String? middleName;
  String lastName;
  String fatherName;
  String gender;
  DateTime dob;
  String mobile;
  String residentialStatus;
  String pan;
  String educationStatus;
  int totalExperienceInYears;
  double netWorth;

  String addressLine1;
  String? addressLine2;
  String landmark;
  String pinCode;
  String village;
  String district;
  String subDistrict;
  String country;
  String state;
  String city;

  String visuallyImpaired;
  bool isAGuarantor;

  Partner({
    required this.relationType,
    required this.ownershipPercentage,
    required this.salutation,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.fatherName,
    required this.gender,
    required this.dob,
    required this.mobile,
    required this.residentialStatus,
    required this.pan,
    required this.educationStatus,
    required this.totalExperienceInYears,
    required this.netWorth,
    required this.addressLine1,
    this.addressLine2,
    required this.landmark,
    required this.pinCode,
    required this.village,
    required this.district,
    required this.subDistrict,
    required this.country,
    required this.state,
    required this.city,
    required this.visuallyImpaired,
    required this.isAGuarantor,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      relationType: json['relationType'],
      ownershipPercentage: json['ownershipPercentage'],
      salutation: json['salutation'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      fatherName: json['fatherName'],
      gender: json['gender'],
      dob: DateTime.parse(json['dob']),
      mobile: json['mobile'],
      residentialStatus: json['residentialStatus'],
      pan: json['pan'],
      educationStatus: json['educationStatus'],
      totalExperienceInYears: json['totalExperienceInYears'],
      netWorth: json['netWorth'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      landmark: json['landmark'],
      pinCode: json['pinCode'],
      village: json['village'],
      district: json['district'],
      subDistrict: json['subDistrict'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      visuallyImpaired: json['visuallyImpaired'],
      isAGuarantor: json['isAGuarantor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'relationType': relationType,
      'ownershipPercentage': ownershipPercentage,
      'salutation': salutation,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'fatherName': fatherName,
      'gender': gender,
      'dob': dob.toIso8601String(),
      'mobile': mobile,
      'residentialStatus': residentialStatus,
      'pan': pan,
      'educationStatus': educationStatus,
      'totalExperienceInYears': totalExperienceInYears,
      'netWorth': netWorth,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'landmark': landmark,
      'pinCode': pinCode,
      'village': village,
      'district': district,
      'subDistrict': subDistrict,
      'country': country,
      'state': state,
      'city': city,
      'visuallyImpaired': visuallyImpaired,
      'isAGuarantor': isAGuarantor,
    };
  }
}
