class FinancialYear {
  int startYear;
  int endYear;

  FinancialYear({required this.startYear, required this.endYear}) {
    if (endYear - startYear != 1) {
      throw Exception("Financial year difference must be 1");
    }
  }
}

class ManualItrPersonal {
  String? id;
  String profileId;
  DateTime timestamp;
  String applicationId;
  String firstName;
  String? middleName;
  String lastName;
  DateTime dob;
  String pan;
  String mobile;
  String email;
  String addressLine1;
  String? addressLine2;
  String landmark;
  String country;
  String pinCode;
  String state;
  String city;
  String? village;
  String? district;
  String? subDistrict;
  Map<FinancialYear, double> netAnnualIncome;

  ManualItrPersonal({
    required this.profileId,
    required this.timestamp,
    required this.applicationId,
    this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.dob,
    required this.pan,
    required this.mobile,
    required this.email,
    required this.addressLine1,
    this.addressLine2,
    required this.landmark,
    required this.country,
    required this.pinCode,
    required this.state,
    required this.city,
    this.village,
    this.district,
    this.subDistrict,
    required this.netAnnualIncome,
  });

  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
      'timestamp': timestamp,
      'applicationId': applicationId,
      'id': id,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'dob': dob,
      'pan': pan,
      'mobile': mobile,
      'email': email,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'landmark': landmark,
      'country': country,
      'pinCode': pinCode,
      'state': state,
      'city': city,
      'village': village,
      'district': district,
      'subDistrict': subDistrict,
      'netAnnualIncome': {
        'startYear': netAnnualIncome.keys.first.startYear,
        'endYear': netAnnualIncome.keys.first.endYear,
        'income': netAnnualIncome.values.first,
      }
    };
  }

  factory ManualItrPersonal.fromJson(Map<String, dynamic> json) {
    return ManualItrPersonal(
      profileId: json['profileId'],
      timestamp: json['timestamp'],
      applicationId: json['applicationId'],
      id: json['id'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      dob: json['dob'],
      pan: json['pan'],
      mobile: json['mobile'],
      email: json['email'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      landmark: json['landmark'],
      country: json['country'],
      pinCode: json['pinCode'],
      state: json['state'],
      city: json['city'],
      village: json['village'],
      district: json['district'],
      subDistrict: json['subDistrict'],
      netAnnualIncome: {
        FinancialYear(
          startYear: json['netAnnualIncome']['startYear'],
          endYear: json['netAnnualIncome']['endYear'],
        ): json['netAnnualIncome']['income'],
      },
    );
  }
}
