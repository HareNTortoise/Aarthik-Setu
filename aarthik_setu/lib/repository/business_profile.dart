import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';

class BusinessProfileRepository {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: AppConstants.backendDomain,
    ),
  );

  final Logger _logger = Logger();

  Future<Map<String,dynamic>> createProfile(Map<String,dynamic> profile) async {
    try {
      final response = await _client.post('/business-profile', data: profile);
      return response.data;
    } catch (e) {
      _logger.e('Error creating business profile: $e');
      return {};
    }
  }

  Future<Map<String,dynamic>> getProfile(String profileId) async {
    try {
      final response = await _client.get('/business-profile/$profileId');
      return response.data;
    } catch (e) {
      _logger.e('Error fetching business profile: $e');
      return {};
    }
  }

  Future<Map<String,dynamic>> updateProfile(String profileId, Map<String,dynamic> profile) async {
    try {
      final response = await _client.put('/business-profile/$profileId', data: profile);
      return response.data;
    } catch (e) {
      _logger.e('Error updating business profile: $e');
      return {};
    }
  }

  Future<Map<String,dynamic>> deleteProfile(String profileId) async {
    try {
      final response = await _client.delete('/business-profile/$profileId');
      return response.data;
    } catch (e) {
      _logger.e('Error deleting business profile: $e');
      return {};
    }
  }
}