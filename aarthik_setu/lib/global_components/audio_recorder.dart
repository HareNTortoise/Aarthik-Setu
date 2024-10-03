import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:permission_handler/permission_handler.dart';
import '../bloc/audio_filler/audio_filler_bloc.dart';


class AudioRecordingWidget extends StatelessWidget {
  const AudioRecordingWidget({super.key});

  void _toggleListening(BuildContext context) async {
    if (true) {
      final bloc = BlocProvider.of<AudioFillerBloc>(context);
      final state = bloc.state;

      if (state is AudioFillerRecording) {
        bloc.add(StopRecording());
      } else {
        bloc.add(StartRecording());
      }
    }
  }

  void _togglePlaying(BuildContext context, AudioFillerStoppedRecording state) {
    final bloc = BlocProvider.of<AudioFillerBloc>(context);
    if (state.audioData != null) {
      if (bloc.state is AudioFillerPlaying) {
        bloc.add(StopPlaying());
      } else {
        bloc.add(StartPlaying());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Material(
        elevation: 20,
        borderRadius: const BorderRadius.all(
          Radius.circular(36),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(36),
            ),
          ),
          width: 280,
          height: 70,
          alignment: Alignment.center,
          child: BlocBuilder<AudioFillerBloc, AudioFillerState>(
            builder: (context, state) {
              if (state is AudioFillerStoppedRecording) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => _togglePlaying(context, state),
                      child: Icon(
                        state.audioData != null ? Icons.play_arrow : Icons.stop,
                        color: state.audioData != null ? Colors.green : Colors.red,
                        size: 30,
                      ),
                    ),
                    Text(
                      'Play Audio',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => _toggleListening(context),
                    child: Icon(
                      state is AudioFillerRecording ? Icons.stop : Icons.mic,
                      color: state is AudioFillerRecording ? Colors.red : Colors.lightBlueAccent,
                      size: 30,
                    ),
                  ),
                  Text(
                    state is AudioFillerRecording ? 'Stop Listening' : 'Record Audio',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
