import '../business/forms/components/main_partner.dart';
import '../business/forms/components/partner.dart';

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
  int noOfEmployees;
  DateTime operationSince;

  bool haveAccessToLabourRawMaterialsAndPower;
  bool havePensionPlanOrInsuranceScheme;

  Map<String, Partner> partners;
  MainPartner mainPartner;

  bool isWorkPlaceSameAsResidence;
  bool? isStayingAtSameAddressProvidedInID;
  int? noOfYears;
  bool haveYouDoneCertificateCourse;
  bool isThereAnyOtherEarningAdultInFamily;
  bool doYouHaveAnyOnGoingMudraLoans;

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
    required this.noOfEmployees,
    required this.operationSince,
    required this.haveAccessToLabourRawMaterialsAndPower,
    required this.havePensionPlanOrInsuranceScheme,
    required this.partners,
    required this.mainPartner,
    required this.isWorkPlaceSameAsResidence,
    this.isStayingAtSameAddressProvidedInID,
    this.noOfYears,
    required this.haveYouDoneCertificateCourse,
    required this.isThereAnyOtherEarningAdultInFamily,
    required this.doYouHaveAnyOnGoingMudraLoans,
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
      noOfEmployees: json['noOfEmployees'],
      operationSince: DateTime.parse(json['operationSince']),
      haveAccessToLabourRawMaterialsAndPower: json['haveAccessToLabourRawMaterialsAndPower'],
      havePensionPlanOrInsuranceScheme: json['havePensionPlanOrInsuranceScheme'],
      partners: json['partners'],
      mainPartner: json['mainPartner'],
      isWorkPlaceSameAsResidence: json['isWorkPlaceSameAsResidence'],
      isStayingAtSameAddressProvidedInID: json['isStayingAtSameAddressProvidedInID'],
      noOfYears: json['noOfYears'],
      haveYouDoneCertificateCourse: json['haveYouDoneCertificateCourse'],
      isThereAnyOtherEarningAdultInFamily: json['isThereAnyOtherEarningAdultInFamily'],
      doYouHaveAnyOnGoingMudraLoans: json['doYouHaveAnyOnGoingMudraLoans'],
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
      'noOfEmployees': noOfEmployees,
      'operationSince': operationSince,
      'haveAccessToLabourRawMaterialsAndPower': haveAccessToLabourRawMaterialsAndPower,
      'havePensionPlanOrInsuranceScheme': havePensionPlanOrInsuranceScheme,
      'partners': partners,
      'mainPartner': mainPartner,
      'isWorkPlaceSameAsResidence': isWorkPlaceSameAsResidence,
      'isStayingAtSameAddressProvidedInID': isStayingAtSameAddressProvidedInID,
      'noOfYears': noOfYears,
      'haveYouDoneCertificateCourse': haveYouDoneCertificateCourse,
      'isThereAnyOtherEarningAdultInFamily': isThereAnyOtherEarningAdultInFamily,
      'doYouHaveAnyOnGoingMudraLoans': doYouHaveAnyOnGoingMudraLoans,
    };
  }
}
