class PersonalLoanApplication {
  String? id;
  String profileId;
  String loanType;

  String? itrFileFormId;
  String? itrManualFormId;
  String? contactDetailsFormId;
  String? basicDetailsFormId;
  String? employmentDetailsFormId;
  String? creditInfoFormId;
  String? bankDetailsFormId;
  String? finalLoanFormId;

  PersonalLoanApplication({
    required this.profileId,
    required this.loanType,
    this.id,
    this.itrFileFormId,
    this.itrManualFormId,
    this.contactDetailsFormId,
    this.basicDetailsFormId,
    this.employmentDetailsFormId,
    this.creditInfoFormId,
    this.bankDetailsFormId,
    this.finalLoanFormId,
  });

  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
      'loanType': loanType,
      'itrFileFormId': itrFileFormId,
      'itrManualFormId': itrManualFormId,
      'contactDetailsFormId': contactDetailsFormId,
      'basicDetailsFormId': basicDetailsFormId,
      'employmentDetailsFormId': employmentDetailsFormId,
      'creditInfoFormId': creditInfoFormId,
      'bankDetailsFormId': bankDetailsFormId,
      'finalLoanFormId': finalLoanFormId,
    };
  }

  factory PersonalLoanApplication.fromJson(Map<String, dynamic> json) {
    return PersonalLoanApplication(
      loanType: json['loanType'],
      profileId: json['profileId'],
      id: json['id'],
      itrFileFormId: json['itrFileFormId'],
      itrManualFormId: json['itrManualFormId'],
      contactDetailsFormId: json['contactDetailsFormId'],
      basicDetailsFormId: json['basicDetailsFormId'],
      employmentDetailsFormId: json['employmentDetailsFormId'],
      creditInfoFormId: json['creditInfoFormId'],
      bankDetailsFormId: json['bankDetailsFormId'],
      finalLoanFormId: json['finalLoanFormId'],
    );
  }
}
