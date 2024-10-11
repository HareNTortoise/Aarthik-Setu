class AmortizationSchedule {
  final double interestPayment;
  final int paymentNumber;
  final double principalPayment;
  final double remainingBalance;
  final double totalPayment;

  AmortizationSchedule({
    required this.interestPayment,
    required this.paymentNumber,
    required this.principalPayment,
    required this.remainingBalance,
    required this.totalPayment,
  });

  factory AmortizationSchedule.fromJson(Map<String, dynamic> json) {
    return AmortizationSchedule(
      interestPayment: json['InterestPayment'],
      paymentNumber: json['PaymentNumber'],
      principalPayment: json['PrincipalPayment'],
      remainingBalance: json['RemainingBalance'],
      totalPayment: json['TotalPayment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'InterestPayment': interestPayment,
      'PaymentNumber': paymentNumber,
      'PrincipalPayment': principalPayment,
      'RemainingBalance': remainingBalance,
      'TotalPayment': totalPayment,
    };
  }
}

class LoanDetails {
  final String estimatedTime;
  final double maxMonthlyPayment;
  final List<AmortizationSchedule> minAmortizationSchedule;
  final double minMonthlyPayment;

  LoanDetails({
    required this.estimatedTime,
    required this.maxMonthlyPayment,
    required this.minAmortizationSchedule,
    required this.minMonthlyPayment,
  });

  factory LoanDetails.fromJson(Map<String, dynamic> json) {
    var amortizationList = json['min_amortization_schedule'] as List;
    List<AmortizationSchedule> amortizationSchedule = amortizationList
        .map((schedule) => AmortizationSchedule.fromJson(schedule))
        .toList();

    return LoanDetails(
      estimatedTime: json['estimated_time'],
      maxMonthlyPayment: json['max_monthly_payment'],
      minAmortizationSchedule: amortizationSchedule,
      minMonthlyPayment: json['min_monthly_payment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'estimated_time': estimatedTime,
      'max_monthly_payment': maxMonthlyPayment,
      'min_amortization_schedule':
      minAmortizationSchedule.map((schedule) => schedule.toJson()).toList(),
      'min_monthly_payment': minMonthlyPayment,
    };
  }
}
