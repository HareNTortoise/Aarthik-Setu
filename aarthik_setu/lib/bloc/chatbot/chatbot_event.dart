part of 'chatbot_bloc.dart';

@immutable
abstract class ChatBotEvent {}

class SendMessageEvent extends ChatBotEvent {
  final String message;
  final bool isUserMessage;

  SendMessageEvent({required this.isUserMessage, required this.message});
}

class SendInitialHelloMessage extends ChatBotEvent {
  final String languageCode;

  SendInitialHelloMessage({required this.languageCode});
}