import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_school/models/classStructure.dart';

const String TODO_COLLECTON_REF = "lesson";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _lessonRef;

  DatabaseService() {
    _lessonRef =
        _firestore.collection(TODO_COLLECTON_REF).withConverter<Lesson>(
            fromFirestore: (snapshots, _) => Lesson.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (lesson, _) => lesson.toJson());
  }

  Stream<QuerySnapshot> getLessons() {
    return _lessonRef.snapshots();
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
}
