class FinalLoanFormPersonal {
  String? id;
  String profileId;
  DateTime timestamp;
  String applicationId;
  String loanPurpose;
  String loanAmount;
  int tenureYears;
  String interestRate;
  String retirementAge;
  bool emiBySalaryAccount;
  bool payOutstandingByTerminalPayments;
  bool paySalaryInSalaryAccount;
  bool issueLetterToYourEmployerToPayOutstandingLoan;
  bool issueLetterToYourEmployerToNotChangeSalaryAccount;
  String repaymentMethod;

  FinalLoanFormPersonal({
    this.id,
    required this.profileId,
    required this.timestamp,
    required this.applicationId,
    required this.loanPurpose,
    required this.loanAmount,
    required this.tenureYears,
    required this.interestRate,
    required this.retirementAge,
    required this.emiBySalaryAccount,
    required this.payOutstandingByTerminalPayments,
    required this.paySalaryInSalaryAccount,
    required this.issueLetterToYourEmployerToPayOutstandingLoan,
    required this.issueLetterToYourEmployerToNotChangeSalaryAccount,
    required this.repaymentMethod,
  });

  factory FinalLoanFormPersonal.fromJson(Map<String, dynamic> json) {
    return FinalLoanFormPersonal(
      id: json['id'],
      profileId: json['profileId'],
      timestamp: json['timestamp'],
      applicationId: json['applicationId'],
      loanPurpose: json['loanPurpose'],
      loanAmount: json['loanAmount'],
      tenureYears: json['tenureYears'],
      interestRate: json['interestRate'],
      retirementAge: json['retirementAge'],
      emiBySalaryAccount: json['emiBySalaryAccount'],
      payOutstandingByTerminalPayments: json['payOutstandingByTerminalPayments'],
      paySalaryInSalaryAccount: json['paySalaryInSalaryAccount'],
      issueLetterToYourEmployerToPayOutstandingLoan: json['issueLetterToYourEmployerToPayOutstandingLoan'],
      issueLetterToYourEmployerToNotChangeSalaryAccount: json['issueLetterToYourEmployerToNotChangeSalaryAccount'],
      repaymentMethod: json['repaymentMethod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileId': profileId,
      'timestamp': timestamp,
      'applicationId': applicationId,
      'loanPurpose': loanPurpose,
      'loanAmount': loanAmount,
      'tenureYears': tenureYears,
      'interestRate': interestRate,
      'retirementAge': retirementAge,
      'emiBySalaryAccount': emiBySalaryAccount,
      'payOutstandingByTerminalPayments': payOutstandingByTerminalPayments,
      'paySalaryInSalaryAccount': paySalaryInSalaryAccount,
      'issueLetterToYourEmployerToPayOutstandingLoan': issueLetterToYourEmployerToPayOutstandingLoan,
      'issueLetterToYourEmployerToNotChangeSalaryAccount': issueLetterToYourEmployerToNotChangeSalaryAccount,
      'repaymentMethod': repaymentMethod,
    };
  }
}
