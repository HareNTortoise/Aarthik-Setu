import 'detailsOfMachinery_mudra.dart';
import 'existingLoanDetail_mudra.dart';

class oneForm {

  // Business Details
  String industry;
  String sector;
  String subSector;
  String msmeRegistrationNumber;
  String udyogAadharMemorandumNumber;
  String productOrServiceDescription;
  String marketingArrangementForProduct;
  String businessPremise;

  // Loan Details
  String purposeOfLoan;
  String assetAcquisition;
  String existingActivities;
  String ProposedActivities;
  String tenure;
  double promoterContribution;
  double loanAmountRequired;

  // Details of machinery/equipment
  List<DetailsOfMachinery> detailsOfMachinery;

  double expectedTurnover;
  double expectedProfit;
  DateTime commercialOperationDate;

  // Existing Loan Details
  List<ExistingLoanDetail> existingLoanDetails;

  oneForm({
    required this.industry,
    required this.sector,
    required this.subSector,
    required this.msmeRegistrationNumber,
    required this.udyogAadharMemorandumNumber,
    required this.productOrServiceDescription,
    required this.marketingArrangementForProduct,
    required this.businessPremise,
    required this.purposeOfLoan,
    required this.assetAcquisition,
    required this.existingActivities,
    required this.ProposedActivities,
    required this.tenure,
    required this.promoterContribution,
    required this.loanAmountRequired,
    required this.detailsOfMachinery,
    required this.expectedTurnover,
    required this.expectedProfit,
    required this.commercialOperationDate,
    required this.existingLoanDetails,
  });

  factory oneForm.fromJson(Map<String, dynamic> json) {
    return oneForm(
      industry: json['industry'],
      sector: json['sector'],
      subSector: json['subSector'],
      msmeRegistrationNumber: json['msmeRegistrationNumber'],
      udyogAadharMemorandumNumber: json['udyogAadharMemorandumNumber'],
      productOrServiceDescription: json['productOrServiceDescription'],
      marketingArrangementForProduct: json['marketingArrangementForProduct'],
      businessPremise: json['businessPremise'],
      purposeOfLoan: json['purposeOfLoan'],
      assetAcquisition: json['assetAcquisition'],
      existingActivities: json['existingActivities'],
      ProposedActivities: json['ProposedActivities'],
      tenure: json['tenure'],
      promoterContribution: json['promoterContribution'],
      loanAmountRequired: json['loanAmountRequired'],
      detailsOfMachinery: json['detailsOfMachinery'],
      expectedTurnover: json['expectedTurnover'],
      expectedProfit: json['expectedProfit'],
      commercialOperationDate: json['commercialOperationDate'],
      existingLoanDetails: json['existingLoanDetails'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'industry': industry,
      'sector': sector,
      'subSector': subSector,
      'msmeRegistrationNumber': msmeRegistrationNumber,
      'udyogAadharMemorandumNumber': udyogAadharMemorandumNumber,
      'productOrServiceDescription': productOrServiceDescription,
      'marketingArrangementForProduct': marketingArrangementForProduct,
      'businessPremise': businessPremise,
      'purposeOfLoan': purposeOfLoan,
      'assetAcquisition': assetAcquisition,
      'existingActivities': existingActivities,
      'ProposedActivities': ProposedActivities,
      'tenure': tenure,
      'promoterContribution': promoterContribution,
      'loanAmountRequired': loanAmountRequired,
      'detailsOfMachinery': detailsOfMachinery,
      'expectedTurnover': expectedTurnover,
      'expectedProfit': expectedProfit,
      'commercialOperationDate': commercialOperationDate,
      'existingLoanDetails': existingLoanDetails,
    };
  }

}