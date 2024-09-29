import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class PersonalProfileRepository {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: AppConstants.backendDomain,
    ),
  );

  final Logger _logger = Logger();


  Future<Map<String,dynamic>> createProfile(Map<String,dynamic> profile) async {
    try {
      final response = await _client.post('/profile', data: profile);
      return response.data;
    } catch (e) {
      _logger.e('Error creating profile: $e');
      return {};
    }
  }
  
  Future<Map<String,dynamic>> getProfile(String profileId) async {
    try {
      final response = await _client.get('/profile/$profileId');
      return response.data;
    } catch (e) {
      _logger.e('Error fetching profile: $e');
      return {};
    }
  }

  Future<Map<String,dynamic>> updateProfile(String profileId, Map<String,dynamic> profile) async {
    try {
      final response = await _client.put('/profile/$profileId', data: profile);
      return response.data;
    } catch (e) {
      _logger.e('Error updating profile: $e');
      return {};
    }
  }

  Future<Map<String,dynamic>> deleteProfile(String profileId) async {
    try {
      final response = await _client.delete('/profile/$profileId');
      return response.data;
    } catch (e) {
      _logger.e('Error deleting profile: $e');
      return {};
    }
  }
}
