import 'package:file_picker/file_picker.dart';

class BankDetails {
  String? id;
  String profileId;
  DateTime timestamp;
  String applicationId;

  String bankName;
  bool salaryAccount;
  DateTime accountSinceMonth;
  DateTime accountSinceYear;
  FilePickerResult bankAccountStatementOne;
  FilePickerResult? bankAccountStatementTwo;
  FilePickerResult? bankAccountStatementThree;

  BankDetails({
    required this.profileId,
    required this.bankName,
    required this.salaryAccount,
    required this.accountSinceMonth,
    required this.accountSinceYear,
    required this.bankAccountStatementOne,
    this.bankAccountStatementTwo,
    this.bankAccountStatementThree,
    required this.applicationId,
    required this.timestamp,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'profileId': profileId,
      'bankName': bankName,
      'salaryAccount': salaryAccount,
      'accountSince': accountSinceMonth,
      'bankAccountStatementOne': bankAccountStatementOne,
      'bankAccountStatementTwo': bankAccountStatementTwo,
      'bankAccountStatementThree': bankAccountStatementThree,
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
      accountSinceMonth: json['accountSinceMonth'],
      accountSinceYear: json['accountSinceYear'],
      bankAccountStatementOne: json['bankAccountStatementOne'],
      bankAccountStatementTwo: json['bankAccountStatementTwo'],
      bankAccountStatementThree: json['bankAccountStatementThree'],
      applicationId: json['applicationId'],
      timestamp: json['timestamp'],
      id: json['id'],
    );
  }
}