class ExistingLoanDetail {
  String nameOfLender;
  double sanctionedAmount;
  double oSLoanAmount;
  double emiAmount;
  String loanType;
  double collateralAmount;
  String status;

  ExistingLoanDetail({
    required this.nameOfLender,
    required this.sanctionedAmount,
    required this.oSLoanAmount,
    required this.emiAmount,
    required this.loanType,
    required this.collateralAmount,
    required this.status,
  });

  factory ExistingLoanDetail.fromJson(Map<String, dynamic> json) {
    return ExistingLoanDetail(
      nameOfLender: json['nameOfLender'],
      sanctionedAmount: json['sanctionedAmount'],
      oSLoanAmount: json['oSLoanAmount'],
      emiAmount: json['emiAmount'],
      loanType: json['loanType'],
      collateralAmount: json['collateralAmount'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameOfLender': nameOfLender,
      'sanctionedAmount': sanctionedAmount,
      'oSLoanAmount': oSLoanAmount,
      'emiAmount': emiAmount,
      'loanType': loanType,
      'collateralAmount': collateralAmount,
      'status': status,
    };
  }

}