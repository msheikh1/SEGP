import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_large_text.dart';

class MessageScreen extends StatefulWidget {
  final Function(int) onStudentTap;

  const MessageScreen({Key? key, required this.onStudentTap}) : super(key: key);

  @override
  MessageScreenState createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topNavigationBar(),
          SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: AppLargeText(text: "Messaging"),
          ),
        ], // Added closing bracket for Column children
      ),
    );
  }
}

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
