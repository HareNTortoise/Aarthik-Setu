class Collateral {
  String collateralType;
  double collateralAmount;
  
  Collateral({
    required this.collateralType,
    required this.collateralAmount,
  });
}

class ExistingLoan {
  String nameOfLender;
  double sanctionedAmount;
  double outstandingAmount;
  double emiAmount;
  String loanType;
  double collateralAmount;
  String status;
  
  ExistingLoan({
    required this.nameOfLender,
    required this.sanctionedAmount,
    required this.outstandingAmount,
    required this.emiAmount,
    required this.loanType,
    required this.collateralAmount,
    required this.status,
  });
}

class FinalLoanFormBusiness {
  String? id;
  String profileId;
  DateTime timestamp;
  String applicationId;

  String industry;
  String sectorName;
  String subSectorName;
  String msmeRegistrationNumber;
  String udyogAadharNumber;
  String productDescription;

  List<Collateral> collaterals;

  double loanAmountRequired;
  double promoterContribution;
  String purposeOfLoan;

  double projectSales;
  bool businessISOCertified;

  String factoryPremise;
  String knowHow;
  String competition;

  List<ExistingLoan> existingLoans;

  double existingLoanAmount;
  double additionalLoanRequired;
  double totalLoanAmount;

  FinalLoanFormBusiness({
    this.id,
    required this.profileId,
    required this.timestamp,
    required this.applicationId,
    required this.industry,
    required this.sectorName,
    required this.subSectorName,
    required this.msmeRegistrationNumber,
    required this.udyogAadharNumber,
    required this.productDescription,
    required this.collaterals,
    required this.loanAmountRequired,
    required this.promoterContribution,
    required this.purposeOfLoan,
    required this.projectSales,
    required this.businessISOCertified,
    required this.factoryPremise,
    required this.knowHow,
    required this.competition,
    required this.existingLoans,
    required this.existingLoanAmount,
    required this.additionalLoanRequired,
    required this.totalLoanAmount,
  });
  
  factory FinalLoanFormBusiness.fromJson(Map<String, dynamic> json) {
    return FinalLoanFormBusiness(
      id: json['id'],
      profileId: json['profileId'],
      timestamp: json['timestamp'],
      applicationId: json['applicationId'],
      industry: json['industry'],
      sectorName: json['sectorName'],
      subSectorName: json['subSectorName'],
      msmeRegistrationNumber: json['msmeRegistrationNumber'],
      udyogAadharNumber: json['udyogAadharNumber'],
      productDescription: json['productDescription'],
      collaterals: List<Collateral>.from(json['collaterals'].map((collateral) => Collateral(
        collateralType: collateral['collateralType'],
        collateralAmount: collateral['collateralAmount'],
      ))),
      loanAmountRequired: json['loanAmountRequired'],
      promoterContribution: json['promoterContribution'],
      purposeOfLoan: json['purposeOfLoan'],
      projectSales: json['projectSales'],
      businessISOCertified: json['businessISOCertified'],
      factoryPremise: json['factoryPremise'],
      knowHow: json['knowHow'],
      competition: json['competition'],
      existingLoans: List<ExistingLoan>.from(json['existingLoans'].map((existingLoan) => ExistingLoan(
        nameOfLender: existingLoan['nameOfLender'],
        sanctionedAmount: existingLoan['sanctionedAmount'],
        outstandingAmount: existingLoan['outstandingAmount'],
        emiAmount: existingLoan['emiAmount'],
        loanType: existingLoan['loanType'],
        collateralAmount: existingLoan['collateralAmount'],
        status: existingLoan['status'],
      ))),
      existingLoanAmount: json['existingLoanAmount'],
      additionalLoanRequired: json['additionalLoanRequired'],
      totalLoanAmount: json['totalLoanAmount'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileId': profileId,
      'timestamp': timestamp,
      'applicationId': applicationId,
      'industry': industry,
      'sectorName': sectorName,
      'subSectorName': subSectorName,
      'msmeRegistrationNumber': msmeRegistrationNumber,
      'udyogAadharNumber': udyogAadharNumber,
      'productDescription': productDescription,
      'collaterals': collaterals.map((collateral) => {
        'collateralType': collateral.collateralType,
        'collateralAmount': collateral.collateralAmount,
      }).toList(),
      'loanAmountRequired': loanAmountRequired,
      'promoterContribution': promoterContribution,
      'purposeOfLoan': purposeOfLoan,
      'projectSales': projectSales,
      'businessISOCertified': businessISOCertified,
      'factoryPremise': factoryPremise,
      'knowHow': knowHow,
      'competition': competition,
      'existingLoans': existingLoans.map((existingLoan) => {
        'nameOfLender': existingLoan.nameOfLender,
        'sanctionedAmount': existingLoan.sanctionedAmount,
        'outstandingAmount': existingLoan.outstandingAmount,
        'emiAmount': existingLoan.emiAmount,
        'loanType': existingLoan.loanType,
        'collateralAmount': existingLoan.collateralAmount,
        'status': existingLoan.status,
      }).toList(),
      'existingLoanAmount': existingLoanAmount,
      'additionalLoanRequired': additionalLoanRequired,
      'totalLoanAmount': totalLoanAmount,
    };
  }
}
