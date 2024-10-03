import 'package:aarthik_setu/repository/chatbot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'chatbot_event.dart';
part 'chatbot_state.dart';

class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  final ChatBotRepository chatBotRepository;
final Logger _logger = Logger();
  ChatBotBloc({required this.chatBotRepository}) : super(ChatInitialState()) {
    on<SendMessageEvent>((event, emit) async {
      if (event.isUserMessage) {
        emit(ChatMessageReceivedState(messages: [...(state as ChatMessageReceivedState).messages, event.message]));
      } else {
        final String response = await chatBotRepository.genAiResponse(event.message);
        emit(ChatMessageReceivedState(messages: [...((state as ChatMessageReceivedState).messages), response]));
      }
    });

    on<SendInitialHelloMessage>((event, emit) async {
      emit(ChatMessageReceivedState(messages: const ["Hello I'm Setu AI, how can I help you?"]));
    });
  }
}
