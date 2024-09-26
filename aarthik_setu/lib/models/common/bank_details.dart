class BankDetails {
  String? id;
  String profileId;
  DateTime timestamp;
  String applicationId;
  String bankName;
  bool salaryAccount;
  DateTime accountSince;
  List<String> bankAccountStatements;

  BankDetails({
    required this.profileId,
    required this.bankName,
    required this.salaryAccount,
    required this.accountSince,
    required this.bankAccountStatements,
    required this.applicationId,
    required this.timestamp,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
      'bankName': bankName,
      'salaryAccount': salaryAccount,
      'accountSince': accountSince,
      'bankAccountStatements': bankAccountStatements,
      'applicationId': applicationId,
      'timestamp': timestamp,
      'id': id,
    };
  }

  factory BankDetails.fromJson(Map<String, dynamic> json) {
    return BankDetails(
      profileId: json['profileId'],
      bankName: json['bankName'],
      salaryAccount: json['salaryAccount'],
      accountSince: json['accountSince'],
      bankAccountStatements: json['bankAccountStatements'],
      applicationId: json['applicationId'],
      timestamp: json['timestamp'],
      id: json['id'],
    );
  }
}
