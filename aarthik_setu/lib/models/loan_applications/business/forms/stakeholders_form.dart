import 'components/business_details.dart';
import 'components/main_partner.dart';
import 'components/partner.dart';

class StakeholdersForm {
  String? id;
  String profileId;
  DateTime timestamp;
  String applicationId;

  final BusinessDetails businessDetails;
  final List<Partner> partners;
  final MainPartner mainPartner;

  StakeholdersForm({
    this.id,
    required this.profileId,
    required this.timestamp,
    required this.applicationId,
    required this.businessDetails,
    required this.partners,
    required this.mainPartner,
  });

  factory StakeholdersForm.fromJson(Map<String, dynamic> json) {
    return StakeholdersForm(
      id: json['_id'],
      profileId: json['profileId'],
      timestamp: DateTime.parse(json['timestamp']),
      applicationId: json['applicationId'],
      businessDetails: json['businessDetails'],
      partners: json['partners'],
      mainPartner: json['mainPartner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileId': profileId,
      'timestamp': timestamp.toIso8601String(),
      'applicationId': applicationId,
      'businessDetails': businessDetails,
      'partners': partners,
      'mainPartner': mainPartner,
    };
  }
}
