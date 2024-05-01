import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_school/widgets/message.dart';

class ChatService {
  // Get Firestore Instance & Auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("parent").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // Go through each user
        final parent = doc.data();

        //return user
        return parent;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String receiverID, message) async {
    // Get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // Create a new message
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    //construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // sort the ids(this ensure the ChatroomID is the same for any two people)
    String chatRoomID = ids.join('_');

    // add new message to the database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get Messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    //construct a chat room ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
