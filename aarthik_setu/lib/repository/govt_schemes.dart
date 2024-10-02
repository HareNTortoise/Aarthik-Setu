import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';

class GovernmentScheme {
  final String relatedScheme;
  final String description;
  final String natureOfAssistance;
  final String whoCanApply;
  final String howToApply;

  GovernmentScheme({
    required this.relatedScheme,
    required this.description,
    required this.natureOfAssistance,
    required this.whoCanApply,
    required this.howToApply,
  });

  // FACTORY JSON METHODS, JSON ATTRIBUTES IN CAMEL CASE

  factory GovernmentScheme.fromJson(Map<String, dynamic> json) {
    return GovernmentScheme(
      relatedScheme: json['relatedScheme'],
      description: json['description'],
      natureOfAssistance: json['natureOfAssistance'],
      whoCanApply: json['whoCanApply'],
      howToApply: json['howToApply'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'relatedScheme': relatedScheme,
      'description': description,
      'natureOfAssistance': natureOfAssistance,
      'whoCanApply': whoCanApply,
      'howToApply': howToApply,
    };
  }
}

class GovernmentSchemesRepository {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: AppConstants.backendDomain,
    ),
  );

  final Logger _logger = Logger();

  Future<List<GovernmentScheme>> getSchemes({int page = 0, int limit = 10}) async {
    try {
      final response = await _client.get('/govt_schemes', queryParameters: {'limit': limit, 'offset':  page});
      final List<GovernmentScheme> schemes = [];
      for (final scheme in response.data) {
        schemes.add(GovernmentScheme.fromJson(scheme as Map<String, dynamic>));
      }
      return schemes;
    } catch (e) {
      _logger.e('Error creating business profile: $e');
      return [];
    }
  }
}
