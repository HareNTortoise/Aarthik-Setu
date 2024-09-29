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
  String? landmark;
  String country;
  String pinCode;
  String state;
  String city;
  String? village;
  String district;
  String subDistrict;
  MapEntry<FinancialYear, double> netAnnualIncomeOne;
  MapEntry<FinancialYear, double>? netAnnualIncomeTwo;
  MapEntry<FinancialYear, double>? netAnnualIncomeThree;

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
    required this.district,
    required this.subDistrict,
    required this.netAnnualIncomeOne,
    this.netAnnualIncomeTwo,
    this.netAnnualIncomeThree,
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
      'netAnnualIncomeOne': {
        'startYear': netAnnualIncomeOne.key.startYear,
        'endYear': netAnnualIncomeOne.key.endYear,
        'income': netAnnualIncomeOne.value,
      },
      if (netAnnualIncomeTwo != null)
        'netAnnualIncomeTwo': {
          'startYear': netAnnualIncomeTwo!.key.startYear,
          'endYear': netAnnualIncomeTwo!.key.endYear,
          'income': netAnnualIncomeTwo!.value,
        },
      if (netAnnualIncomeThree != null)
        'netAnnualIncomeThree': {
          'startYear': netAnnualIncomeThree!.key.startYear,
          'endYear': netAnnualIncomeThree!.key.endYear,
          'income': netAnnualIncomeThree!.value,
        },
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
      netAnnualIncomeOne: MapEntry(
        FinancialYear(
          startYear: json['netAnnualIncomeOne']['startYear'],
          endYear: json['netAnnualIncomeOne']['endYear'],
        ),
        json['netAnnualIncomeOne']['income'],
      ),
      netAnnualIncomeTwo: json['netAnnualIncomeTwo'] != null
          ? MapEntry(
              FinancialYear(
                startYear: json['netAnnualIncomeTwo']['startYear'],
                endYear: json['netAnnualIncomeTwo']['endYear'],
              ),
              json['netAnnualIncomeTwo']['income'],
            )
          : null,
      netAnnualIncomeThree: json['netAnnualIncomeThree'] != null
          ? MapEntry(
              FinancialYear(
                startYear: json['netAnnualIncomeThree']['startYear'],
                endYear: json['netAnnualIncomeThree']['endYear'],
              ),
              json['netAnnualIncomeThree']['income'],
            )
          : null,
    );
  }
}
