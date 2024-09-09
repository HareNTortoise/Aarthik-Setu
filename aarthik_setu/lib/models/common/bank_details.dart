
class BankDetails{
  String bankName;
  bool salaryAccount;
  DateTime accountSince;
  List<String> bankAccountStatements;

  BankDetails({
    required this.bankName,
    required this.salaryAccount,
    required this.accountSince,
    required this.bankAccountStatements,
  });

  Map<String, dynamic> toJson() {
    return {
      'bankName': bankName,
      'salaryAccount': salaryAccount,
      'accountSince': accountSince,
      'bankAccountStatement': bankAccountStatements,
    };
  }

  factory BankDetails.fromJson(Map<String, dynamic> json) {
    return BankDetails(
      bankName: json['bankName'],
      salaryAccount: json['salaryAccount'],
      accountSince: json['accountSince'],
      bankAccountStatements: json['bankAccountStatements'],
    );
  }
}
