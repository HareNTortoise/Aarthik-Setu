part of 'chatbot_bloc.dart';

@immutable
abstract class ChatBotState {}

class ChatInitialState extends ChatBotState {}

class ChatLoadingState extends ChatBotState {
  final List<String> currentMessages;

  ChatLoadingState({required this.currentMessages});
}

class ChatLoadedState extends ChatBotState {
  final List<String> messages;

  ChatLoadedState({required this.messages});
}

class ChatErrorState extends ChatBotState {
  final String errorMessage;

  ChatErrorState(this.errorMessage);
}
