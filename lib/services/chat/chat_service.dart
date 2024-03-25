import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService{
  // Get Firestore Instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("parents").snapshots().map((snapshot) {
      return snapshot.docs.map((doc){
        // Go through each user
        final parent = doc.data();

        //return user
        return parent;
      }).toList();
    });
  }

}