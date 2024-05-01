import 'package:cloud_firestore/cloud_firestore.dart';

// This class represents an activity model.
class ActivityModel {
  // The document ID of the activity in the database.
  String? docID;
  // The title of the activity.
  final String titleActivity;
  // The description of the activity.
  final String description;
  // The start time of the activity.
  final String startTime;
  // The end time of the activity.
  final String endTime;

  // Constructor for the ActivityModel class.
  ActivityModel(
      {this.docID,
      required this.titleActivity,
      required this.description,
      required this.startTime,
      required this.endTime});

  // Converts the activity model to a map.
  Map<String, dynamic> toMap() {
    return {
      'docID': this.docID,
      'titleActivity': this.titleActivity,
      'description': this.description,
      'startTime': this.startTime,
      'endTime': this.endTime,
    };
  }

  // Creates an activity model from a map.
  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      titleActivity: map['titleActivity'] as String,
      description: map['description'] as String,
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
    );
  }

  // Creates an activity model from a Firestore document snapshot.
  factory ActivityModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return ActivityModel(
      docID: doc.id,
        titleActivity: doc['titleActivity'],
        description: doc['description'],
        startTime: doc['startTime'],
        endTime: doc['endTime']);
  }
}