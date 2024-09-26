class EmploymentDetails {
  String employmentType;
  String employerStatus;
  String designation;
  String modeOfSalary;
  String grossMonthlyIncome;
  String netMonthlyIncome;
  String? id;
  String profileId;
  DateTime timestamp;
  String applicationId;

  EmploymentDetails({
    required this.employmentType,
    required this.employerStatus,
    required this.designation,
    required this.modeOfSalary,
    required this.grossMonthlyIncome,
    required this.netMonthlyIncome,
    required this.profileId,
    required this.timestamp,
    required this.applicationId,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'employmentType': employmentType,
      'employerStatus': employerStatus,
      'designation': designation,
      'modeOfSalary': modeOfSalary,
      'grossMonthlyIncome': grossMonthlyIncome,
      'netMonthlyIncome': netMonthlyIncome,
      'profileId': profileId,
      'timestamp': timestamp,
      'applicationId': applicationId,
      'id': id,
    };
  }

  factory EmploymentDetails.fromJson(Map<String, dynamic> json) {
    return EmploymentDetails(
      employmentType: json['employmentType'],
      employerStatus: json['employerStatus'],
      designation: json['designation'],
      modeOfSalary: json['modeOfSalary'],
      grossMonthlyIncome: json['grossMonthlyIncome'],
      netMonthlyIncome: json['netMonthlyIncome'],
      profileId: json['profileId'],
      timestamp: json['timestamp'],
      applicationId: json['applicationId'],
      id: json['id'],
    );
  }
}
