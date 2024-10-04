import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/audio_filler/audio_filler_bloc.dart';

class AudioRecordingWidget extends StatelessWidget {
  const AudioRecordingWidget({super.key, required this.onSubmitAudio});

  final Function(PlatformFile audioFile) onSubmitAudio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Material(
        elevation: 20,
        borderRadius: const BorderRadius.all(Radius.circular(36)),
        child: BlocBuilder<AudioFillerBloc, AudioFillerState>(builder: (context, state) {
          if (state is AudioFillerLoading) {
            return CircularProgressIndicator();
          } else if (state is AudioFillerStoppedRecording) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(36),
                ),
              ),
              width: 310,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      context.read<AudioFillerBloc>().add(StartPlaying());
                    },
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      context.read<AudioFillerBloc>().add(ResetAudioFiller());
                    },
                    child: Icon(
                      Icons.refresh,
                      color: Colors.orange,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Audio Recorded',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      onSubmitAudio(state.audioFile);
                    },
                    child: Icon(
                      Icons.check,
                      color: Colors.cyan,
                      size: 30,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is AudioFillerRecording) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(36),
                ),
              ),
              width: 280,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      context.read<AudioFillerBloc>().add(StopRecording());
                    },
                    child: Icon(
                      Icons.stop,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Stop Recording',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is AudioFillerPlaying) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(36),
                ),
              ),
              width: 280,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      context.read<AudioFillerBloc>().add(StopPlaying());
                    },
                    child: Icon(
                      Icons.stop,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Stop Playing',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(36),
                ),
              ),
              width: 280,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      context.read<AudioFillerBloc>().add(StartRecording());
                    },
                    child: Icon(
                      Icons.mic,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Start Recording',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
