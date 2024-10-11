import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';
import '../models/lenders.dart';

class LendersRepository {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: AppConstants.backendDomain,
    ),
  );

  final Logger _logger = Logger();

  Future<List<Lender>> getLenders(int limit, int offset) async {
    try {
      final response = await _client.get('/lenders', queryParameters: {
        'limit': 20,
        'offset': 0,
      });
      List<Lender> lenders = [];
      for (var lender in response.data) {
        lenders.add(Lender.fromJson(lender as Map<String, dynamic>));
      }
      return lenders;
    } catch (e) {
      _logger.e('Error getGenAiResponse $e');
      return [];
    }
  }
}
