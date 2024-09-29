class BusinessLoanApplication {
  String? id;
  String profileId;
  String loanType;

  String? itrFileFormId;
  String? gstFileFormId;
  String? gstManualFormId;
  String? bankDetailsFormId;
  String? stakeHolderFormId;
  String? finalLoanFormId;

  BusinessLoanApplication({
    required this.profileId,
    required this.loanType,
    this.id,
    this.itrFileFormId,
    this.gstFileFormId,
    this.gstManualFormId,
    this.bankDetailsFormId,
    this.stakeHolderFormId,
    this.finalLoanFormId,
  });

  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
      'loanType': loanType,
      'itrFileFormId': itrFileFormId,
      'gstFileFormId': gstFileFormId,
      'gstManualFormId': gstManualFormId,
      'bankDetailsFormId': bankDetailsFormId,
      'stakeHolderFormId': stakeHolderFormId,
      'finalLoanFormId': finalLoanFormId,
    };
  }

  factory BusinessLoanApplication.fromJson(Map<String, dynamic> json) {
    return BusinessLoanApplication(
      loanType: json['loanType'],
      profileId: json['profileId'],
      id: json['id'],
      itrFileFormId: json['itrFileFormId'],
      gstFileFormId: json['gstFileFormId'],
      gstManualFormId: json['gstManualFormId'],
      bankDetailsFormId: json['bankDetailsFormId'],
      stakeHolderFormId: json['stakeHolderFormId'],
      finalLoanFormId: json['finalLoanFormId'],
    );
  }
}
