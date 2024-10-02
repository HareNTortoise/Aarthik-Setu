import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:aarthik_setu/models/loan_applications/personal/personal_profile.dart';
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
  
  Future<List<PersonalProfile>> getProfile(String userId) async {
    try {
      final response = await _client.get('/personal/profile/$userId');
      final List<PersonalProfile> profiles = [];
      for (final profile in response.data) {
        profiles.add(PersonalProfile.fromJson(profile as Map<String, dynamic>));
      }
      return profiles;
    } catch (e) {
      _logger.e('Error fetching profile: $e');
      return [];
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
