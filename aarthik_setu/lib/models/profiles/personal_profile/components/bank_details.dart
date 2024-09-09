
class BankDetails{
  String bankName;
  bool salaryAccount;
  DateTime accountSince;
  String bankAccountStatement;

  BankDetails({
    required this.bankName,
    required this.salaryAccount,
    required this.accountSince,
    required this.bankAccountStatement,
  });

  Map<String, dynamic> toJson() {
    return {
      'bankName': bankName,
      'salaryAccount': salaryAccount,
      'accountSince': accountSince,
      'bankAccountStatement': bankAccountStatement,
    };
  }

  factory BankDetails.fromJson(Map<String, dynamic> json) {
    return BankDetails(
      bankName: json['bankName'],
      salaryAccount: json['salaryAccount'],
      accountSince: json['accountSince'],
      bankAccountStatement: json['bankAccountStatement'],
    );
  }
}
