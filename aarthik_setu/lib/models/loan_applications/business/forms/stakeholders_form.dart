import 'components/business_details.dart';
import 'components/main_partner.dart';
import 'components/partner.dart';

class StakeholdersForm {
  final BusinessDetails businessDetails;
  final List<Partner> partners;
  final MainPartner mainPartner;

  StakeholdersForm({
    required this.businessDetails,
    required this.partners,
    required this.mainPartner,
  });

  factory StakeholdersForm.fromJson(Map<String, dynamic> json) {
    return StakeholdersForm(
      businessDetails: json['businessDetails'],
      partners: json['partners'],
      mainPartner: json['mainPartner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'businessDetails': businessDetails,
      'partners': partners,
      'mainPartner': mainPartner,
    };
  }
}
