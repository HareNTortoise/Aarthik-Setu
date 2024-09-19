import 'package:aarthik_setu/models/profiles/business_profile/components/main_partner.dart';
import 'package:aarthik_setu/models/profiles/business_profile/components/partner.dart';

class KeyPersonDetails {
  String addressLine1;
  String addressLine2;
  String landmark;
  String pinCode;
  String village;
  String district;
  String subDistrict;
  String country;
  String state;
  String city;
  DateTime operationSince;

  Map<String, Partner> partners;
  MainPartner mainPartner;

  KeyPersonDetails({
    required this.addressLine1,
    required this.addressLine2,
    required this.landmark,
    required this.pinCode,
    required this.village,
    required this.district,
    required this.subDistrict,
    required this.country,
    required this.state,
    required this.city,
    required this.operationSince,
    required this.partners,
    required this.mainPartner,
  });

  factory KeyPersonDetails.fromJson(Map<String, dynamic> json) {
    return KeyPersonDetails(
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
      operationSince: DateTime.parse(json['operationSince']),
      partners: json['partners'],
      mainPartner: json['mainPartner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'operationSince': operationSince.toIso8601String(),
      'partners': partners,
      'mainPartner': mainPartner,
    };
  }
}
