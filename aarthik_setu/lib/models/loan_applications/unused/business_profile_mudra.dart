import '../../common/bank_details.dart';
import '../business/forms/stakeholders_form.dart';
import '../business/forms/manual_itr_business.dart';

class BusinessProfile{
  Map<(int, int), String> itr;
  Map<(int, int), ManualItrBusiness> manualItr;
  List<BankDetails> bankDetails;
  StakeholdersForm keyPersonDetails;

  BusinessProfile({
    required this.itr,
    required this.manualItr,
    required this.bankDetails,
    required this.keyPersonDetails,
  });

  factory BusinessProfile.fromJson(Map<String, dynamic> json) {
    return BusinessProfile(
      itr: json['itr'],
      manualItr: json['manualItr'],
      bankDetails: json['bankDetails'],
      keyPersonDetails: json['keyPersonDetails'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itr': itr,
      'manualItr': manualItr,
      'bankDetails': bankDetails,
      'keyPersonDetails': keyPersonDetails,
    };
  }
}