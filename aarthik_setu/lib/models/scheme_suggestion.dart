import 'package:aarthik_setu/repository/govt_schemes.dart';

class SchemeSuggestions {
  final String message;
  final List<GovernmentScheme> schemes;

  SchemeSuggestions({
    required this.message,
    required this.schemes,
  });

  factory SchemeSuggestions.fromJson(Map<String, dynamic> json) {
    var schemesList = json['schemes'] as List;
    List<GovernmentScheme> schemes = schemesList.map((scheme) => GovernmentScheme.fromJson(scheme)).toList();

    return SchemeSuggestions(
      message: json['message'],
      schemes: schemes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'schemes': schemes.map((scheme) => scheme.toJson()).toList(),
    };
  }
}
