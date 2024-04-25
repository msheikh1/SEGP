import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_school/models/classStructure.dart';
import 'package:get/get.dart';
import 'package:flutter_school/Screens/Authetication/authenticate.dart';
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

  Future<void> saveNewUser(
      UserCredential userCredential,
      String name,
      String email,
      String userType,
      String district,
      String school,
      List<String> childrenNames) async {
    Map<String, dynamic> userData = {
      'email': email,
      'name': name,
      'type': userType,
      // Add more common fields if needed
    };

    await _firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(userData);

    switch (userType) {
      case 'Parent':
        await _firestore
            .collection("parents")
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'children': childrenNames,
        });

        // Add each child to the 'children' collection with an empty 'teachers' array
        for (String child in childrenNames) {
          String randomId = _generateRandomId();
          await _firestore.collection("children").doc(randomId).set({
            'name': child,
            'teachers': [],
          });
        }
        break;
      case 'Teacher':
        await _firestore
            .collection("teacher")
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'school': school,
          'District': district,
        });
        break;
      // Add admin-specific fields if needed
      default:
        throw Exception('Invalid user type');
    }
  }

  String _generateRandomId() {
    // Generate a random alphanumeric string of length 20
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
      20,
      (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ));
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

  Future<List<String>> getStudents(User user) async {
    try {
      String? userName = await getUserName(user);
      String name = userName ?? '';

      List<String> students = [];
      QuerySnapshot querySnapshot = await _firestore
          .collection("children")
          .where("teachers", arrayContains: name)
          .get();
      querySnapshot.docs.forEach((doc) {
        String name = doc['name']; // Assuming 'teachers' is a list
        if (name != null) {
          students.add(name); // Add each teacher as a student
        }
      });
      return students;
    } catch (e) {
      print('Error getting students list for');
      return [];
    }
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

  Future<List<String>> getTeachersList() async {
    try {
      List<String> teachers = [];
      QuerySnapshot querySnapshot =
          await _firestore.collection("teacher").get();
      querySnapshot.docs.forEach((doc) {
        teachers.add(doc['name']);
      });
      return teachers;
    } catch (e) {
      print('Error getting teachers list: $e');
      return [];
    }
  }

  Future<List<String>> getStudentsList(String teacherName) async {
    try {
      List<String> students = [];
      QuerySnapshot querySnapshot = await _firestore
          .collection("children")
          .where("teachers", arrayContains: teacherName)
          .get();
      querySnapshot.docs.forEach((doc) {
        students.add(doc['name']);
      });
      return students;
    } catch (e) {
      print('Error getting students list for $teacherName: $e');
      return [];
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
      // Show a confirmation message to the user
    } catch (e) {
      // Handle errors
      print('Failed to send password reset email: $e');
      // Show an error message to the user
    }
  }

  Future<List<String>?> getAllStudents() async {
    try {
      List<String> allStudents = [];
      QuerySnapshot querySnapshot =
          await _firestore.collection("children").get();
      querySnapshot.docs.forEach((doc) {
        String name = doc['name'];
        allStudents.add(name);
      });
      return allStudents;
    } catch (e) {
      print('Error getting all students: $e');
      return null;
    }
  }

  Future<void> addTeacherToStudent(
      String studentName, String teacherName) async {
    try {
      // Query the collection to find the document with the matching studentName
      QuerySnapshot studentSnapshot = await _firestore
          .collection("children")
          .where("name", isEqualTo: studentName)
          .get();

      // Check if any documents were found
      if (studentSnapshot.docs.isNotEmpty) {
        // Get the first document (assuming student names are unique)
        DocumentSnapshot studentDoc = studentSnapshot.docs.first;
        print(studentDoc);

        // Cast the data to a Map<String, dynamic>
        Map<String, dynamic>? studentData =
            studentDoc.data() as Map<String, dynamic>?;
        print(studentData);

        // Check if the studentData is not null
        if (studentData != null) {
          // Get the current teachers array from the document data
          List<dynamic>? teachersData = studentData['teachers'];

          // Check if the teachers array exists and doesn't already contain the teacherName
          if (teachersData != null && !teachersData.contains(teacherName)) {
            // Update the 'teachers' array for the student
            await _firestore.collection("children").doc(studentDoc.id).update({
              'teachers': FieldValue.arrayUnion([teacherName]),
            });
          } else {
            // Teacher already exists in the student's teachers array, do nothing
            print(
                'Teacher $teacherName already exists for student $studentName');
          }
        } else {
          // Handle case where studentData is null
          print('Student data is null for student $studentName');
        }
      } else {
        // Document with the specified studentName not found
        print('Student document with name $studentName not found');
      }
    } catch (e) {
      print('Error adding teacher to student: $e');
    }
  }
}
