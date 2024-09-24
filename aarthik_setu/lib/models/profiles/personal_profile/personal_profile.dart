import '../../common/bank_details.dart';
import 'components/contact_details.dart';
import 'components/employment_details.dart';
import 'components/manual_itr_personal.dart';
import 'components/credit_info.dart';

class PersonalProfile {
  String id;
  String userId;
  String name;
  String pan;
  Map<(int, int), String> itr;
  Map<(int, int), ManualItrPersonal> manualItr;
  List<BankDetails> bankDetails;
  EmploymentDetails employmentDetails;
  ContactDetails contactDetails;
  List<CreditInfo> creditInfo;

  PersonalProfile({
    required this.id,
    required this.userId,
    required this.name,
    required this.pan,
    required this.itr,
    required this.manualItr,
    required this.bankDetails,
    required this.employmentDetails,
    required this.contactDetails,
    required this.creditInfo,
  });
}
