class BusinessDetails {
  String buildingNo;
  String street;
  String landmark;
  String pinCode;
  String country;
  String state;
  String city;
  String district;
  String subDistrict;
  String village;
  int month;
  int year;

  BusinessDetails({
    required this.buildingNo,
    required this.street,
    required this.landmark,
    required this.pinCode,
    required this.country,
    required this.state,
    required this.city,
    required this.district,
    required this.subDistrict,
    required this.village,
    required this.month,
    required this.year,
  });

  factory BusinessDetails.fromJson(Map<String, dynamic> json) {
    return BusinessDetails(
      buildingNo: json['buildingNo'],
      street: json['street'],
      landmark: json['landmark'],
      pinCode: json['pinCode'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      district: json['district'],
      subDistrict: json['subDistrict'],
      village: json['village'],
      month: json['month'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'buildingNo': buildingNo,
      'street': street,
      'landmark': landmark,
      'pinCode': pinCode,
      'country': country,
      'state': state,
      'city': city,
      'district': district,
      'subDistrict': subDistrict,
      'village': village,
      'month': month,
      'year': year,
    };
  }
}
