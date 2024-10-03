part of 'audio_filler_bloc.dart';

@immutable
abstract class AudioFillerEvent {}

class StartRecording extends AudioFillerEvent {}

class StopRecording extends AudioFillerEvent {}

class StartPlaying extends AudioFillerEvent {
}

class StopPlaying extends AudioFillerEvent {}
