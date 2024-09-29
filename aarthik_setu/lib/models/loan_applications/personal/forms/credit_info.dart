class CreditInfoUnit {
  final String loanType;
  final String lender;
  final String sanctionedAmount;
  final String outstandingAmount;
  final String emiAmount;

  CreditInfoUnit({
    required this.loanType,
    required this.lender,
    required this.sanctionedAmount,
    required this.outstandingAmount,
    required this.emiAmount,
  });
}

class CreditInfo {
  String? id;
  String profileId;
  DateTime timestamp;
  String applicationId;

  List<CreditInfoUnit> creditInfoUnits;

  CreditInfo({
    required this.profileId,
    required this.timestamp,
    required this.applicationId,
    required this.creditInfoUnits,
  });

  CreditInfo.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        profileId = map['profileId'],
        timestamp = DateTime.parse(map['timestamp']),
        applicationId = map['applicationId'],
        creditInfoUnits = List<CreditInfoUnit>.from(
          map['creditInfoUnits'].map(
            (creditInfoUnit) => CreditInfoUnit(
              loanType: creditInfoUnit['loanType'],
              lender: creditInfoUnit['lender'],
              sanctionedAmount: creditInfoUnit['sanctionedAmount'],
              outstandingAmount: creditInfoUnit['outstandingAmount'],
              emiAmount: creditInfoUnit['emiAmount'],
            ),
          ),
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profileId': profileId,
      'timestamp': timestamp.toIso8601String(),
      'applicationId': applicationId,
      'creditInfoUnits': creditInfoUnits
          .map((creditInfoUnit) => {
                'loanType': creditInfoUnit.loanType,
                'lender': creditInfoUnit.lender,
                'sanctionedAmount': creditInfoUnit.sanctionedAmount,
                'outstandingAmount': creditInfoUnit.outstandingAmount,
                'emiAmount': creditInfoUnit.emiAmount,
              })
          .toList(),
    };
  }
}
