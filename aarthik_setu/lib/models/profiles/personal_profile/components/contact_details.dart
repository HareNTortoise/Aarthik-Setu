
class ContactDetails{
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
    };
  }
}
