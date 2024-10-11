

class Lender {
  String lenderName;
  String lenderType;
  String position;
  String location;
  String loanType;
  String loanAmountRange;
  String interestRate;
  String loanTerm;
  String eligibilityCriteria;
  bool collateralRequired;
  String applicationDeadline;
  bool remote;
  String seniority;
  int experienceLevel;
  int skillsRequired;
  int industryExperience;
  int fairMatchScore;
  bool h1bSponsor;
  List<String> benefits;
  String loanDescription;
  String applicationStatus;
  int applicantCount;
  String imageUrl;

  Lender({
    required this.lenderName,
    required this.lenderType,
    required this.position,
    required this.location,
    required this.loanType,
    required this.loanAmountRange,
    required this.interestRate,
    required this.loanTerm,
    required this.eligibilityCriteria,
    required this.collateralRequired,
    required this.applicationDeadline,
    required this.remote,
    required this.seniority,
    required this.experienceLevel,
    required this.skillsRequired,
    required this.industryExperience,
    required this.fairMatchScore,
    required this.h1bSponsor,
    required this.benefits,
    required this.loanDescription,
    required this.applicationStatus,
    required this.applicantCount,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'lender_name': lenderName,
      'lender_type': lenderType,
      'position': position,
      'location': location,
      'loan_type': loanType,
      'loan_amount_range': loanAmountRange,
      'interest_rate': interestRate,
      'loan_term': loanTerm,
      'eligibility_criteria': eligibilityCriteria,
      'collateral_required': collateralRequired,
      'application_deadline': applicationDeadline,
      'remote': remote,
      'seniority': seniority,
      'experience_level': experienceLevel,
      'skills_required': skillsRequired,
      'industry_experience': industryExperience,
      'fair_match_score': fairMatchScore,
      'h1b_sponsor': h1bSponsor,
      'benefits': benefits,
      'loan_description': loanDescription,
      'application_status': applicationStatus,
      'applicant_count': applicantCount,
      'image_url': imageUrl,
    };
  }

  factory Lender.fromJson(Map<String, dynamic> json) {
    return Lender(
      lenderName: json['lender_name'],
      lenderType: json['lender_type'],
      position: json['position'],
      location: json['location'],
      loanType: json['loan_type'],
      loanAmountRange: json['loan_amount_range'],
      interestRate: json['interest_rate'],
      loanTerm: json['loan_term'],
      eligibilityCriteria: json['eligibility_criteria'],
      collateralRequired: json['collateral_required'],
      applicationDeadline: json['application_deadline'],
      remote: json['remote'],
      seniority: json['seniority'],
      experienceLevel: json['experience_level'],
      skillsRequired: json['skills_required'],
      industryExperience: json['industry_experience'],
      fairMatchScore: json['fair_match_score'],
      h1bSponsor: json['h1b_sponsor'],
      benefits: List<String>.from(json['benefits']),
      loanDescription: json['loan_description'],
      applicationStatus: json['application_status'],
      applicantCount: json['applicant_count'],
      imageUrl: json['image_url'],
    );
  }
}
