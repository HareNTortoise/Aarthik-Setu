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
  final FlutterSoundRecorder _myRecorder = FlutterSoundRecorder(logLevel: Level.off);
  final FlutterSoundPlayer _myPlayer = FlutterSoundPlayer(logLevel: Level.off);
  final Logger _logger = Logger();

  AudioFillerBloc() : super(AudioFillerInitial()) {
    on<InitializeAudioFiller>(_onInitializeAudioFiller);
    on<StartRecording>(_onStartRecording);
    on<StopRecording>(_onStopRecording);
    on<StartPlaying>(_onStartPlaying);
    on<StopPlaying>(_onStopPlaying);
    on<ResetAudioFiller>(_onResetAudioFiller);
  }

  Future<void> _onInitializeAudioFiller(InitializeAudioFiller event, Emitter<AudioFillerState> emit) async {
    emit(AudioFillerLoading());
    _myRecorder.openRecorder();
    _myPlayer.openPlayer();
    emit(AudioFillerInitial());
  }

  Future<void> _onStartRecording(StartRecording event, Emitter<AudioFillerState> emit) async {
    try {
      await _myRecorder.startRecorder(codec: Codec.defaultCodec, toFile: 'voice');
      emit(AudioFillerRecording());
    } catch (e) {
      _logger.e('Error starting recorder: $e');
      emit(AudioFillerError('Failed to start recording'));
    }
  }

  Future<void> _onStopRecording(StopRecording event, Emitter<AudioFillerState> emit) async {
    try {
      XFile? file;
      PlatformFile? audioFile;
      Uint8List? audioData;
      await _myRecorder.stopRecorder();
      final value = await _myRecorder.getRecordURL(path: 'voice');
      file = XFile(value!);
      audioData = await file.readAsBytes();
      audioFile = PlatformFile(
        path: value,
        name: "audio.mp3",
        size: await file.length(),
        bytes: audioData,
      );
      emit(AudioFillerStoppedRecording(audioData: audioData, audioFile: audioFile));
    } catch (e) {
      _logger.e('Error stopping recorder: $e');
      emit(AudioFillerError('Failed to stop recording'));
    }
  }

  Future<void> _onStartPlaying(StartPlaying event, Emitter<AudioFillerState> emit) async {
    try {
      await _myPlayer.startPlayer(
        fromDataBuffer: (state as AudioFillerStoppedRecording).audioData,
        codec: Codec.defaultCodec,
        whenFinished: () {
          add(StopPlaying());
        },
      );
      emit(AudioFillerPlaying(
        audioData: (state as AudioFillerStoppedRecording).audioData,
        audioFile: (state as AudioFillerStoppedRecording).audioFile,
      ));
    } catch (e) {
      _logger.e('Error starting player: $e');
      emit(AudioFillerError('Failed to play audio'));
    }
  }

  Future<void> _onStopPlaying(StopPlaying event, Emitter<AudioFillerState> emit) async {
    await _myPlayer.stopPlayer();
    emit(AudioFillerStoppedRecording(
      audioData: (state as AudioFillerPlaying).audioData,
      audioFile: (state as AudioFillerPlaying).audioFile,
    ));
  }

  Future<void> _onResetAudioFiller(ResetAudioFiller event, Emitter<AudioFillerState> emit) async {
    emit(AudioFillerLoading());
    await _myRecorder.closeRecorder();
    await _myRecorder.openRecorder();
    emit(AudioFillerInitial());
  }
}
