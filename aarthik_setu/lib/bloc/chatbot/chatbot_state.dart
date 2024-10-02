part of 'chatbot_bloc.dart';

@immutable
abstract class ChatBotState {}

class ChatInitialState extends ChatBotState {}

class ChatLoadingState extends ChatBotState {}

class ChatMessageReceivedState extends ChatBotState {
  final List<String> messages;

  ChatMessageReceivedState({required this.messages});
}

class ChatErrorState extends ChatBotState {
  final String errorMessage;

  ChatErrorState(this.errorMessage);
}
