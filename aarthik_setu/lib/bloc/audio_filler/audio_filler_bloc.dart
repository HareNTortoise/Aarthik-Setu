import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:typed_data';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

part 'audio_filler_event.dart';
part 'audio_filler_state.dart';

class AudioFillerBloc extends Bloc<AudioFillerEvent, AudioFillerState> {
  final FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _myPlayer = FlutterSoundPlayer();
  final Logger _logger = Logger();
  Uint8List? _audioData;


  AudioFillerBloc() : super(AudioFillerInitial()) {
    on<StartRecording>(_onStartRecording);
    on<StopRecording>(_onStopRecording);
    on<StartPlaying>(_onStartPlaying);
    on<StopPlaying>(_onStopPlaying);
  }

  Future<void> _onStartRecording(StartRecording event, Emitter<AudioFillerState> emit) async {
    try {
      await _myRecorder.openRecorder();
      await _myRecorder.startRecorder(codec: Codec.defaultCodec, toFile: 'voice');
      emit(AudioFillerRecording());
    } catch (e) {
      _logger.e('Error starting recorder: $e');
      emit(AudioFillerError('Failed to start recording'));
    }
  }

  Future<void> _onStopRecording(StopRecording event, Emitter<AudioFillerState> emit) async {
    try {
      String? path = await _myRecorder.stopRecorder();
      XFile file;
      PlatformFile? audioFile;
      _myRecorder.getRecordURL(path: 'voice').then((value) async {
        file = XFile(value!);
         audioFile = PlatformFile(
            path: value, name: "Recorded_Audio.mp3", size: await file.length(), bytes: await file.readAsBytes());

        emit(AudioFillerStoppedRecording(audioData: _audioData!, audioFile: audioFile!));
      });

    } catch (e) {
      _logger.e('Error stopping recorder: $e');
      emit(AudioFillerError('Failed to stop recording'));
    }
  }

  Future<void> _onStartPlaying(StartPlaying event, Emitter<AudioFillerState> emit) async {
    if (_audioData != null) {
      try {
        await _myPlayer.startPlayer(
          fromDataBuffer: _audioData!,
          codec: Codec.defaultCodec,
          whenFinished: () {
            add(StopPlaying());
          },
        );
        emit(AudioFillerPlaying());
      } catch (e) {
        _logger.e('Error starting player: $e');
        emit(AudioFillerError('Failed to play audio'));
      }
    }
  }

  Future<void> _onStopPlaying(StopPlaying event, Emitter<AudioFillerState> emit) async {
    await _myPlayer.stopPlayer();
    emit(AudioFillerStoppedPlaying());
  }
}
