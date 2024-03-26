import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverName;
  const ChatPage({super.key, required this.receiverName});

  //text controller
  final TextEditingController _messageController = Textt

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiverName),),
    );
  }
}
