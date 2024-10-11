class LoanScheme {
  final String id; // Unique ID for the loan scheme
  final String lenderId; // ID of the lender providing this loan scheme
  final String name;
  final String interestRate;
  final String startingTenure; // Initial tenure
  final String tenure; // Final tenure
  final String startingLoanAmount; // Initial loan amount
  final String loanAmount;
  final String loanType; // 'Personal' or 'Business'

  LoanScheme({
    required this.id,
    required this.lenderId,
    required this.name,
    required this.interestRate,
    required this.startingTenure,
    required this.tenure,
    required this.startingLoanAmount,
    required this.loanAmount,
    required this.loanType,
  });
}

class DummyLender {
  final String id; // Unique ID for the lender
  final String name;
  final String type; // e.g., 'Bank', 'Individual'
  final List<LoanScheme> loanSchemes;

  DummyLender({
    required this.id,
    required this.name,
    required this.type,
    required this.loanSchemes,
  });


}

class DummyDataLenders {
  final List<DummyLender> personalLenders = [
    DummyLender(
      id: 'lender_001',
      name: 'Bank A',
      type: 'Bank',
      loanSchemes: [
        LoanScheme(
          id: 'loan_scheme_001',
          lenderId: 'lender_001',
          name: 'Personal Loan',
          interestRate: '10%',
          startingTenure: '1 year',
          tenure: '5 years',
          startingLoanAmount: '100000',
          loanAmount: '500000',
          loanType: 'Personal',
        ),
        LoanScheme(
          id: 'loan_scheme_002',
          lenderId: 'lender_001',
          name: 'Education Loan',
          interestRate: '9%',
          startingTenure: '1 year',
          tenure: '10 years',
          startingLoanAmount: '50000',
          loanAmount: '300000',
          loanType: 'Personal',
        ),
      ],
    ),
    DummyLender(
      id: 'lender_002',
      name: 'John Doe',
      type: 'Individual',
      loanSchemes: [
        LoanScheme(
          id: 'loan_scheme_003',
          lenderId: 'lender_002',
          name: 'Personal Micro Loan',
          interestRate: '12%',
          startingTenure: '6 months',
          tenure: '3 years',
          startingLoanAmount: '50000',
          loanAmount: '250000',
          loanType: 'Personal',
        ),
      ],
    ),
    DummyLender(
      id: 'lender_003',
      name: 'Union Bank',
      type: 'Bank',
      loanSchemes: [
        LoanScheme(
          id: 'loan_scheme_004',
          lenderId: 'lender_003',
          name: 'Home Improvement Loan',
          interestRate: '8.5%',
          startingTenure: '1 year',
          tenure: '15 years',
          startingLoanAmount: '150000',
          loanAmount: '750000',
          loanType: 'Personal',
        ),
      ],
    ),
    DummyLender(
      id: 'lender_004',
      name: 'Fast Cash Lending',
      type: 'Company',
      loanSchemes: [
        LoanScheme(
          id: 'loan_scheme_005',
          lenderId: 'lender_004',
          name: 'Instant Personal Loan',
          interestRate: '14%',
          startingTenure: '3 months',
          tenure: '1 year',
          startingLoanAmount: '15000',
          loanAmount: '50000',
          loanType: 'Personal',
        ),
      ],
    ),
  ];

  final List<DummyLender> businessLenders = [
    DummyLender(
      id: 'lender_005',
      name: 'Bank B',
      type: 'Bank',
      loanSchemes: [
        LoanScheme(
          id: 'loan_scheme_006',
          lenderId: 'lender_005',
          name: 'Small Business Loan',
          interestRate: '7.5%',
          startingTenure: '2 years',
          tenure: '7 years',
          startingLoanAmount: '200000',
          loanAmount: '500000',
          loanType: 'Business',
        ),
      ],
    ),
    DummyLender(
      id: 'lender_006',
      name: 'Capital Finance',
      type: 'Company',
      loanSchemes: [
        LoanScheme(
          id: 'loan_scheme_007',
          lenderId: 'lender_006',
          name: 'Business Growth Loan',
          interestRate: '11%',
          startingTenure: '1 year',
          tenure: '4 years',
          startingLoanAmount: '300000',
          loanAmount: '1000000',
          loanType: 'Business',
        ),
      ],
    ),
    DummyLender(
      id: 'lender_007',
      name: 'Green Finance Bank',
      type: 'Bank',
      loanSchemes: [
        LoanScheme(
          id: 'loan_scheme_008',
          lenderId: 'lender_007',
          name: 'Eco-Friendly Business Loan',
          interestRate: '9.5%',
          startingTenure: '1 year',
          tenure: '6 years',
          startingLoanAmount: '250000',
          loanAmount: '750000',
          loanType: 'Business',
        ),
      ],
    ),
    DummyLender(
      id: 'lender_008',
      name: 'Micro Lender Co.',
      type: 'Individual',
      loanSchemes: [
        LoanScheme(
          id: 'loan_scheme_009',
          lenderId: 'lender_008',
          name: 'Business Micro Loan',
          interestRate: '15%',
          startingTenure: '6 months',
          tenure: '2 years',
          startingLoanAmount: '20000',
          loanAmount: '100000',
          loanType: 'Business',
        ),
      ],
    ),
  ];
}
