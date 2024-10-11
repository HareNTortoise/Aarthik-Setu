import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';
import '../models/lenders.dart';
import '../models/loan_details.dart';

class LoanDetailsRepository {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: AppConstants.backendDomain,
    ),
  );

  final Logger _logger = Logger();

  Future<LoanDetails> getLoanDetails(Lender? lender) async {
    try {
      final response = await _client.post('/loan/abcdefghi/abcdefghi/lender',
          data: lender?.toJson() ??
              {
                "lender_name": "State Bank of India",
                "lender_type": "Bank",
                "position": "Loan Officer",
                "location": "Mumbai",
                "loan_type": "Working Capital Loan",
                "loan_amount_range": "₹50,000 - ₹50 lakhs",
                "interest_rate": "10.5% - 12.5%",
                "loan_term": "1 year - 5 years",
                "eligibility_criteria": "MSME registered with the government, minimum turnover of ₹10 lakhs",
                "collateral_required": true,
                "application_deadline": "2024-03-31",
                "remote": true,
                "seniority": "Experienced Borrower",
                "experience_level": 50,
                "skills_required": 60,
                "industry_experience": 40,
                "fair_match_score": 70,
                "h1b_sponsor": false,
                "benefits": ["Low interest rates", "Flexible repayment options"],
                "loan_description": "Working capital loan for businesses to meet day-to-day operational expenses.",
                "application_status": "Open",
                "applicant_count": 120,
                "image_url": "https://github.com/HareNTortoise/Aarthik-Setu/blob/main/assets/lenders/sbi.png"
              });
      return LoanDetails.fromJson(response.data);
    } catch (e) {
      _logger.e('Error getGenAiResponse $e');
      return LoanDetails(
        estimatedTime: '',
        maxMonthlyPayment: 0,
        minAmortizationSchedule: [],
        minMonthlyPayment: 0,
      );
    }
  }
}
