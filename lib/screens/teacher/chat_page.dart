// Import necessary packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/services/chat/chat_service.dart';

import '../../widgets/chat_bubble.dart';
import '../../widgets/input_field.dart';

// ChatPage is a stateless widget that displays the chat interface
class ChatPage extends StatelessWidget {
  // receiverName and receiverID are required parameters
  final String receiverName;
  final String receiverID;

  // Constructor
  ChatPage({super.key, required this.receiverName, required this.receiverID});

  // Controller for the message input field
  final TextEditingController _messageController = TextEditingController();

  // Instances of chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // Function to send a message
  void sendMessage() async {
    // Check if the message input field is not empty
    if (_messageController.text.isNotEmpty) {
      // Send the message
      await _chatService.sendMessage(receiverID, _messageController.text);

      // Clear the message input field
      _messageController.clear();
    }
  }

  // Build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(receiverName),
          backgroundColor: Colors.transparent,
          foregroundColor: myDarkBlue,
          elevation: 0,
        ),
        body: Column(
          children: [
            // Display all messages
            Expanded(
              child: _buildMessageList(),
            ),
            // Display the user input field
            _buildUserInput(context),
          ],
        ));
  }

  // Function to build the list of messages
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderID),
        builder: (context, snapshot) {
          // Handle errors
          if (snapshot.hasError) {
            return Text("Build Message Error");
          }

          // Display loading text while waiting for the data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading.. ");
          }

          // Return a list view of messages
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  // Function to build a single message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Check if the sender is the current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // Align the message to the right if the sender is the current user, otherwise align to the left
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

  // Function to build the user input field
  Widget _buildUserInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 50.0),
      child: Row(
        children: [
          Container(
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'gallery');
              },
              icon: const Icon(Icons.image_search, color: Colors.white),
            ),
          ),
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