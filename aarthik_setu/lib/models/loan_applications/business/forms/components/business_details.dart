class BusinessDetails {
  String addressLineOne;
  String? addressLineTwo;
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
    required this.addressLineOne,
    this.addressLineTwo,
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
      addressLineOne: json['addressLineOne'],
      addressLineTwo: json['addressLineTwo'],
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
      'addressLineOne': addressLineOne,
      'addressLineTwo': addressLineTwo,
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
