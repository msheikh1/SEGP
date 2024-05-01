import 'package:cloud_firestore/cloud_firestore.dart';

// Message is a class that represents a chat message
class Message {
  // senderID is the ID of the user who sent the message
  final String senderID;
  // senderEmail is the email of the user who sent the message
  final String senderEmail;
  // receiverID is the ID of the user who will receive the message
  final String receiverID;
  // message is the content of the message
  final String message;
  // timestamp is the time when the message was sent
  final Timestamp timestamp;

  // Constructor
  Message({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.message,
    required this.timestamp,
  });

  // toMap is a method that converts a Message object to a map
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}