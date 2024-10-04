import 'package:aarthik_setu/repository/chatbot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'chatbot_event.dart';

part 'chatbot_state.dart';

class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  final ChatBotRepository chatBotRepository;
  final Logger _logger = Logger();

  ChatBotBloc({required this.chatBotRepository}) : super(ChatLoadedState(messages: ["Hello I'm Setu AI, how can I help you?"])) {
    on<SendMessageEvent>((event, emit) async {
      emit(ChatLoadingState(currentMessages:(state as ChatLoadedState).messages ));
      if (event.isUserMessage) {
        emit(ChatLoadedState(messages: [...(state as ChatLoadingState).currentMessages, event.message]));
      } else {
        final String response = await chatBotRepository.genAiResponse(event.message);
        emit(ChatLoadedState(messages: [...(state as ChatLoadingState).currentMessages, response]));
      }
    });
  }
}
