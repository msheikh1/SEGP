import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_school/models/classStructure.dart';
import 'package:get/get.dart';
import 'package:flutter_school/Screens/Authetication/authenticate.dart';

const String TODO_COLLECTON_REF = "lesson";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  final _authService = AuthService();
  late User user;
  late final CollectionReference _lessonRef;

  DatabaseService() {
    _lessonRef =
        _firestore.collection(TODO_COLLECTON_REF).withConverter<Lesson>(
            fromFirestore: (snapshots, _) => Lesson.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (lesson, _) => lesson.toJson());
  }

  Future<Stream<QuerySnapshot<Object?>>> getLessons() async {
    User? temp = _authService.getCurrentUser();
    if (temp != null) {
      user = temp;
    }
    String? userName = await getUserName(user);
    String name = userName ?? '';
    print("name: " + name);
    return _lessonRef.where('teacher', isEqualTo: name).snapshots();
  }

  void addLesson(Lesson lesson) async {
    _lessonRef.add(lesson);
  }

  Future<void> updateLesson(Lesson lesson, Lesson updatedLesson) async {
    print(lesson.toJson());
    String lessonID = await getID(lesson);
    if (lessonID.isNotEmpty) {
      await _lessonRef.doc(lessonID).update(updatedLesson.toJson());
    } else {
      print('Error: Lesson ID is empty or null');
    }
  }

  Future<void> deleteELesson(Lesson lesson) async {
    String lessonID = await getID(lesson);
    _lessonRef.doc(lessonID).delete();
  }

  Future<String> getID(Lesson lesson) async {
    try {
      // Query Firestore for the lesson
      final querySnapshot = await _lessonRef
          .where("name", isEqualTo: lesson.name)
          .where("details", isEqualTo: lesson.details)
          .where("month", isEqualTo: lesson.month)
          .where("teacher", isEqualTo: lesson.teacher)
          .get();

      // Retrieve the document ID if the lesson exists
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        // Lesson not found
        return "";
      }
    } catch (e) {
      // Error occurred
      print("Error getting lesson ID: $e");
      return "";
    }
  }

  Future<void> saveNewUser(UserCredential userCredential, String name) async {
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'email': userCredential.user!.email,
      'name': name,
      // Add more fields if needed
    });
  }

  Future<String?> getUserName(User user) async {
    if (user != null) {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: user.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // User found in Firestore
        final userData = querySnapshot.docs[0].data();
        if (userData != null && userData is Map<String, dynamic>) {
          final String name = userData['name'];
          return name;
        } else {
          return null;
        }
      } else {
        // User not found in Firestore
        // Handle this case accordingly
        return null;
      }
    } else {
      // User is not logged in
      // Handle this case accordingly
      return null;
    }
  }

// Usage example:
}
