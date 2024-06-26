import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:flutter_school/Screens/Teacher/chat_page.dart';
import 'package:flutter_school/services/chat/chat_service.dart';

import '../../widgets/app_large_text.dart';
import 'package:flutter_school/Screens/Teacher/components/parent_tile.dart';

// This widget represents the message screen for a parent.
class MessageScreen extends StatefulWidget {
  // The function to be executed when a student is tapped.
  final Function(String, String, int) onStudentTap;

  // Constructor for the MessageScreen class.
  const MessageScreen({Key? key, required this.onStudentTap}) : super(key: key);

  @override
  MessageScreenState createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  // The service for the chat.
  final ChatService _chatService = ChatService();
  // The service for the authentication.
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // Returns a Scaffold widget that contains the message screen.
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topNavigationBar(),
          SizedBox(
            height: 25,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: AppLargeText(text: "Messaging"),
          ),
          Expanded(child: _buildParentList()),
        ], // Added closing bracket for Column children
      ),
    );
  }

  // This method builds the parent list.
  Widget _buildParentList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          // error
          if (snapshot.hasError) {
            return const Text("Snapshot Error");
          }
          // loading..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }

          // return list view
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildParentListItem(userData, context))
                .toList(),
          );
        });
  }

  // This method builds a parent list item.
  Widget _buildParentListItem(
      Map<String, dynamic>? parentData, BuildContext context) {
    if (parentData == null || parentData["name"] == null) {
      print("noooooooooooooooooooooooooo");
      return SizedBox(); // or any other appropriate fallback widget
    }

    String parentName = parentData["name"];
    String parentID = parentData["id"];
    print(parentName);

    return ParentTile(
      text: parentName,
      onTap: () {
        widget.onStudentTap?.call(parentName, parentData["id"], 11);
      },
    );
  }
}

// This function builds the top navigation bar.
_topNavigationBar() {
  return Container(
      padding: const EdgeInsets.only(top: 50, left: 20),
      child: Row(
        children: [
          Icon(Icons.menu, size: 30, color: Colors.black54),
          Expanded(child: Container()),
          Container(
            margin: const EdgeInsets.only(right: 20),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withOpacity(0.5),
            ),
          )
        ],
      ));
}