import 'package:flutter/material.dart';

// ChatBubble is a stateless widget that displays a chat bubble
class ChatBubble extends StatelessWidget {
  // message is the text displayed in the chat bubble
  // isCurrentUser is a boolean that indicates whether the current user sent the message
  final String message;
  final bool isCurrentUser;

  // Constructor
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  // Build method
  @override
  Widget build(BuildContext context) {
    return Container(
      // Set the decoration of the chat bubble
      // The color of the chat bubble is green if the current user sent the message, otherwise it's grey
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.green : Colors.grey.shade500,
        borderRadius: BorderRadius.circular(12),
      ),
      // Set the padding and margin of the chat bubble
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      // Display the message text in the chat bubble
      child: Text(message, style: TextStyle(color: Colors.white),),
    );
  }
}