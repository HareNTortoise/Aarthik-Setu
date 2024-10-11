import 'package:aarthik_setu/models/scheme_suggestion.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';
import '../models/lenders.dart';

class SchemeSuggestionsRepository {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: AppConstants.backendDomain,
    ),
  );

  final Logger _logger = Logger();

  Future<SchemeSuggestions> getSchemeSuggestions() async {
    try {
      final response = await _client.get('/suggest_schemes/abcdefghi/abcdefghi');
      final suggestions = SchemeSuggestions.fromJson(response.data);
      return suggestions;
    } catch (e) {
      _logger.e('Error getGenAiResponse $e');
      return SchemeSuggestions(message: 'Error', schemes: []);
    }
  }
}
