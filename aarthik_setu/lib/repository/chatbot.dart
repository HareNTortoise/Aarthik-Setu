import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';

class ChatBotRepository {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: AppConstants.backendDomain,
    ),
  );

  final Logger _logger = Logger();

  Future<String> genAiResponse(String query) async {
    try {
      final response = await _client.post('/chat', data: FormData.fromMap({'message': query}));
      return response.data['response'];
    } catch (e) {
      _logger.e('Error getGenAiResponse $e');
      return '';
    }
  }
}
