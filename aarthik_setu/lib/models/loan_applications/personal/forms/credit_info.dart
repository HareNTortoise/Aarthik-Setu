class CreditInfo {
  String? id;
  String profileId;
  DateTime timestamp;
  String applicationId;
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
    required this.profileId,
    required this.timestamp,
    required this.applicationId,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'loanType': loanType,
      'lender': lender,
      'sanctionedAmount': sanctionedAmount,
      'outstandingAmount': outstandingAmount,
      'emiAmount': emiAmount,
      'profileId': profileId,
      'timestamp': timestamp,
      'applicationId': applicationId,
      'id': id,
    };
  }

  factory CreditInfo.fromJson(Map<String, dynamic> json) {
    return CreditInfo(
      loanType: json['loanType'],
      lender: json['lender'],
      sanctionedAmount: json['sanctionedAmount'],
      outstandingAmount: json['outstandingAmount'],
      emiAmount: json['emiAmount'],
      profileId: json['profileId'],
      timestamp: json['timestamp'],
      applicationId: json['applicationId'],
      id: json['id'],
    );
  }
}
