import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';

class FormFillerRepository {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: AppConstants.backendDomain,
    ),
  );

  final Logger _logger = Logger();

  Future<Map<String, dynamic>> fillForm(PlatformFile audioFile, List<Map<String, dynamic>> formFields) async {
    try {
      final formData = FormData.fromMap({
        'audioFile': MultipartFile.fromBytes(audioFile.bytes!, filename: 'audio.mp3'),
        'formFields': "$formFields",
      });

      final response = await _client.post('/gen_ai/audio-fill', data: formData);
      return response.data;
    } catch (e) {
      _logger.e('Error form filler: $e');
      return {};
    }
  }
}