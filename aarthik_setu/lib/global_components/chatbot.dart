import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/chatbot/chatbot_bloc.dart';

class CommonChatbot extends StatelessWidget {
  const CommonChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLengthGreaterThanWidth = MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;
    context.read<ChatBotBloc>().add(SendInitialHelloMessage(languageCode: 'en'));
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: isLengthGreaterThanWidth ? 700 : 900,
        width: 900,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            _buildHeader(context, isLengthGreaterThanWidth),
            const Divider(height: 24, color: Colors.black),
            _buildMessagesList(isLengthGreaterThanWidth),
            _buildMessageInputField(context, isLengthGreaterThanWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isLengthGreaterThanWidth) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Setu AI",
                style: GoogleFonts.robotoMono(fontSize: isLengthGreaterThanWidth ? 18 : 34),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessagesList(bool isLengthGreaterThanWidth) {
    return Expanded(
      child: BlocBuilder<ChatBotBloc, ChatBotState>(
        builder: (context, state) {
          if (state is ChatLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatMessageReceivedState) {
            return ListView.builder(
              reverse: false,
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[100],
                  ),
                  child: ListTile(
                    title: Text(
                      state.messages[index],
                      style: TextStyle(fontSize: isLengthGreaterThanWidth ? 16 : 20),
                    ),
                  ),
                );
              },
            );
          } else if (state is ChatErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          return const Center(child: Text('Send a message to Aadarsh AI'));
        },
      ),
    );
  }

  Widget _buildMessageInputField(BuildContext context, bool isLengthGreaterThanWidth) {
    final TextEditingController promptEditingController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: isLengthGreaterThanWidth ? 9 : 7,
            child: TextFormField(
              maxLines: 1,
              controller: promptEditingController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(21),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(38),
                ),
                labelText: "Message Aadarsh",
                hintText: 'Type your message...',
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: isLengthGreaterThanWidth ? 2 : 1,
            child: ElevatedButton(
              onPressed: () {
                final message = promptEditingController.text;
                if (message.isNotEmpty) {
                  context.read<ChatBotBloc>().add(SendMessageEvent(message: message, isUserMessage: true));
                  context.read<ChatBotBloc>().add(SendMessageEvent(message: message, isUserMessage: false));
                  promptEditingController.clear();
                }
              },
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all<Size>(const Size.fromHeight(68)),
                backgroundColor: WidgetStateProperty.all<Color>(Colors.lightBlueAccent),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              child: BlocBuilder<ChatBotBloc, ChatBotState>(
                builder: (context, state) {
                  if (state is ChatLoadingState) {
                    return const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  }
                  return const Text('Send', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}