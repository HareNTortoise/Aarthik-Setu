import 'package:aarthik_setu/models/loan_applications/business/business_profile.dart';
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

  Future<Map<String, dynamic>> createProfile(BusinessProfile businessProfile) async {
    try {
      final response = await _client.post('/personal/profile/${businessProfile.userId}',
          data: FormData.fromMap(businessProfile.toJson()));
      return response.data;
    } catch (e) {
      _logger.e('Error creating business profile: $e');
      return {};
    }
  }

  Future<List<BusinessProfile>> getProfile(String userId) async {
    try {
      final response = await _client.get('/business/profile/$userId');
      final List<BusinessProfile> profiles = [];
      for (final profile in response.data) {
        profiles.add(BusinessProfile.fromJson(profile as Map<String, dynamic>));
      }
      return profiles;
    } catch (e) {
      _logger.e('Error fetching business profile: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> updateProfile(String profileId, Map<String, dynamic> profile) async {
    try {
      final response = await _client.put('/business-profile/$profileId', data: profile);
      return response.data;
    } catch (e) {
      _logger.e('Error updating business profile: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> deleteProfile(String userId, String profileId) async {
    try {
      final response = await _client.delete('/business/profile/$userId/$profileId');
      return response.data;
    } catch (e) {
      _logger.e('Error deleting business profile: $e');
      return {};
    }
  }
}
