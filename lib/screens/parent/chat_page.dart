import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/services/chat/chat_service.dart';

import '../../widgets/chat_bubble.dart';
import '../../widgets/input_field.dart';

// This widget represents the chat page for a parent.
class ChatPage extends StatelessWidget {
  // The name of the receiver.
  final String receiverName;
  // The ID of the receiver.
  final String receiverID;

  // Constructor for the ChatPage class.
  ChatPage({super.key, required this.receiverName, required this.receiverID});

  // The controller for the message text field.
  final TextEditingController _messageController = TextEditingController();

  // The service for the chat.
  final ChatService _chatService = ChatService();
  // The service for the authentication.
  final AuthService _authService = AuthService();

  // This method sends a message.
  void sendMessage() async {
    // If the message text field is not empty, send the message.
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);

      // Clear the message text field.
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Returns a Scaffold widget that contains the chat page.
    return Scaffold(
        appBar: AppBar(
          title: Text(receiverName),
          backgroundColor: Colors.transparent,
          foregroundColor: myDarkBlue,
          elevation: 0,
        ),
        body: Column(
          children: [
            // Display all messages.
            Expanded(
              child: _buildMessageList(),
            ),
            _buildUserInput(),
          ],
        ));
  }

  // This method builds the message list.
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderID),
        builder: (context, snapshot) {
          // If there is an error, display an error message.
          if (snapshot.hasError) {
            return Text("Build Message Error");
          }

          // If the data is still loading, display a loading indicator.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading.. ");
          }

          // If the data has loaded, display the messages in a ListView.
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  // This method builds a message item.
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Check if the sender is the current user.
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // Align the message to the right if the sender is the current user, otherwise align it to the left.
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data["message"],
            isCurrentUser: isCurrentUser,
          )
        ],
      ),
    );
  }

  // This method builds the user input.
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 50.0),
      child: Row(
        children: [
          // The text field should take up most of the space.
          Expanded(
            child: MyInputField(
              hint: 'Type a message',
              controller: _messageController,
              title: '',
            ),
          ),

          SizedBox(
            width: 10,
          ),
          // The send button.
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}