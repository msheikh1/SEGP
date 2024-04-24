import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_school/models/classStructure.dart';
import 'package:get/get.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:firebase_storage/firebase_storage.dart';

const String TODO_COLLECTON_REF = "lesson";
const String TODO_COLLECTON_REF1 = "children";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  final _authService = AuthService();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late User user;
  late final CollectionReference _lessonRef;
  late final CollectionReference _childrenRef;

  DatabaseService() {
    _lessonRef =
        _firestore.collection(TODO_COLLECTON_REF).withConverter<Lesson>(
            fromFirestore: (snapshots, _) => Lesson.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (lesson, _) => lesson.toJson());

    _childrenRef =
        _firestore.collection(TODO_COLLECTON_REF1).withConverter<children>(
            fromFirestore: (snapshots, _) => children.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (child, _) => child.toJson());
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

  Future<Stream<QuerySnapshot<Object?>>> getStudents() async {
    User? temp = _authService.getCurrentUser();
    if (temp != null) {
      user = temp;
    }
    String? userName = await getUserName(user);
    String name = userName ?? '';
    return _childrenRef.where('teacher', isEqualTo: name).snapshots();
  }

  Future<String> uploadUserProfileImage(User user, String imagePath) async {
    try {
      String userId = user.uid;
      Reference ref =
          _storage.ref().child('profile_images').child('$userId.jpg');
      UploadTask uploadTask = ref.putFile(File(imagePath));
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading profile image: $e');
      return '';
    }
  }

  Future<void> setUserProfileImageUrl(User user, String imageUrl) async {
    try {
      String userId = user.uid;
      await _firestore
          .collection('users')
          .doc(userId)
          .update({'profileImageUrl': imageUrl});
    } catch (e) {
      print('Error setting profile image URL: $e');
    }
  }

  Future<String> getUserProfileImageUrl(User user) async {
    try {
      String userId = user.uid;
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();
      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;
      if (userData != null) {
        return userData['profileImageUrl'] ?? '';
      } else {
        return ''; // Return empty string if user data is null
      }
    } catch (e) {
      print('Error getting profile image URL: $e');
      return '';
    }
  }

  Future<String?> getUserType(User user) async {
    if (user != null) {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: user.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // User found in Firestore
        final userData = querySnapshot.docs[0].data();
        if (userData != null && userData is Map<String, dynamic>) {
          final String type = userData['type'];
          print("Type on dataservice side: " + type);
          return type;
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

  Future<List<String>?> getChildren(User user) async {
    String name = "";
    String? tryname = await getUserName(user);
    print(tryname);
    if (tryname != null) {
      name = tryname;
    }

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("parents")
        .where("name", isEqualTo: name)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // User found in Firestore
      final userData = querySnapshot.docs[0].data();
      print(userData);
      if (userData != null && userData is Map<String, dynamic>) {
        final List<dynamic>? childrenData = userData['children'];
        if (childrenData != null) {
          // Convert dynamic list to List<String>
          List<String> children = List<String>.from(childrenData);
          return children;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      // User not found in Firestore
      // Handle this case accordingly
      return null;
    }

// Usage example:
  }

  Future<List<String>?> getTeachers(String child) async {
    List<String> teachers = [];

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("children")
        .where("name", isEqualTo: child)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // User found in Firestore
      final userData = querySnapshot.docs[0].data();
      print(userData);
      if (userData != null && userData is Map<String, dynamic>) {
        final List<dynamic>? teacherData = userData['teachers'];
        if (teacherData != null) {
          // Convert dynamic list to List<String>
          List<String> teachers = List<String>.from(teacherData);
          print(teachers);
          return teachers;
        } else {
          return null;
        }
      } else {
        // User not found in Firestore
        // Handle this case accordingly
        return null;
      }
    }

// Usage example:
  }

  Future<Stream<QuerySnapshot<Lesson>>> getLessonsForTeachers(
      String teacher) async {
    return _lessonRef
        .where('teacher', isEqualTo: teacher)
        .snapshots()
        .map((snapshot) => snapshot as QuerySnapshot<Lesson>);
  }

  Future<Stream<QuerySnapshot<Object?>>> getSelectLessons(DateTime date) async {
    User? temp = _authService.getCurrentUser();
    if (temp != null) {
      user = temp;
    }
    String? userName = await getUserName(user);
    String name = userName ?? '';
    print("name: " + name);
    int dateNumber = date.month;
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    String month = months[dateNumber - 1];
    print(month);
    return _lessonRef
        .where('teacher', isEqualTo: name)
        .where("month", isEqualTo: month)
        .snapshots();
  }

  Future<List<String>> getSchool(User user) async {
    String name = "";
    String? tryname = await getUserName(user);
    List<String> schostrict = ['', ''];
    print(tryname);
    if (tryname != null) {
      name = tryname;
    }

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("teacher")
        .where("name", isEqualTo: name)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // User found in Firestore
      final userData = querySnapshot.docs[0].data();
      print(userData);
      if (userData != null && userData is Map<String, dynamic>) {
        final String school = userData['school'];
        final String district = userData['District'];
        if (school != null && district != null) {
          // Convert dynamic list to List<String>

          schostrict = [school, district];
          print(schostrict);
          return schostrict;
        } else {
          schostrict = ['unknown school', 'unknown district'];
          return schostrict;
        }
      } else {
        return schostrict;
      }
    } else {
      // User not found in Firestore
      // Handle this case accordingly
      return schostrict;
    }

// Usage example:
  }

  Future<Stream<QuerySnapshot<Lesson>>> getLessonsForTeachersForDaily(
      String teacher, DateTime date) async {
    int dateNumber = date.month;
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    String month = months[dateNumber - 1];
    return _lessonRef
        .where('teacher', isEqualTo: teacher)
        .where('month', isEqualTo: month)
        .snapshots()
        .map((snapshot) => snapshot as QuerySnapshot<Lesson>);
  }
}
