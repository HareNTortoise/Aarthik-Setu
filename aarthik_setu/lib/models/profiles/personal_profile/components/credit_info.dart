class CreditInfo {
  String loanType;
  String lender;
  double sanctionedAmount;
  double outstandingAmount;
  double emiAmount;

  CreditInfo({
    required this.loanType,
    required this.lender,
    required this.sanctionedAmount,
    required this.outstandingAmount,
    required this.emiAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      'loanType': loanType,
      'lender': lender,
      'sanctionedAmount': sanctionedAmount,
      'outstandingAmount': outstandingAmount,
      'emiAmount': emiAmount,
    };
  }
}