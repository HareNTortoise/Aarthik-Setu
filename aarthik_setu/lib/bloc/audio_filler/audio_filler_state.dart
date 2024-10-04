part of 'audio_filler_bloc.dart';

@immutable
abstract class AudioFillerState {}

class AudioFillerLoading extends AudioFillerState {}

class AudioFillerInitial extends AudioFillerState {}

class AudioFillerRecording extends AudioFillerState {}

class AudioFillerStoppedRecording extends AudioFillerState {
  final Uint8List audioData;
  final PlatformFile audioFile;

  AudioFillerStoppedRecording({required this.audioData, required this.audioFile});
}

class AudioFillerPlaying extends AudioFillerState {
  final Uint8List audioData;
  final PlatformFile audioFile;

  AudioFillerPlaying({required this.audioData, required this.audioFile});
}

class AudioFillerStoppedPlaying extends AudioFillerState {}

class AudioFillerError extends AudioFillerState {
  final String message;

  AudioFillerError(this.message);
}
