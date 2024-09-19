class EmploymentDetails{
  String employmentType;
  String employerStatus;
  String designation;
  String modeOfSalary;
  String grossMonthlyIncome;
  String netMonthlyIncome;

  EmploymentDetails({
    required this.employmentType,
    required this.employerStatus,
    required this.designation,
    required this.modeOfSalary,
    required this.grossMonthlyIncome,
    required this.netMonthlyIncome,
  });

  Map<String, dynamic> toJson() {
    return {
      'employmentType': employmentType,
      'employerStatus': employerStatus,
      'designation': designation,
      'modeOfSalary': modeOfSalary,
      'grossMonthlyIncome': grossMonthlyIncome,
      'netMonthlyIncome': netMonthlyIncome,
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
    );
  }
}