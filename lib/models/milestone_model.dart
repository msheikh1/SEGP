import 'package:cloud_firestore/cloud_firestore.dart';

// This class represents a milestone model.
class MilestoneModel {
  // The document ID of the milestone in the database.
  String? docID;
  // The title of the milestone.
  final String titleMilestone;
  // The description of the milestone.
  final String description;
  // The level of the milestone.
  final String level;
  // The date of the milestone.
  final String dateMilestone;
  // The time of the milestone.
  final String timeMilestone;
  // The completion status of the milestone.
  final bool isDone;

  // Constructor for the MilestoneModel class.
  MilestoneModel(
      {this.docID,
      required this.titleMilestone,
      required this.description,
      required this.level,
      required this.dateMilestone,
      required this.timeMilestone,
      required this.isDone});

  // Converts the milestone model to a map.
  Map<String, dynamic> toMap() {
    return {
      "docID": docID,
      "titleMilestone": titleMilestone,
      "description": description,
      "level": level,
      "dateMilestone": dateMilestone,
      "timeMilestone": timeMilestone,
      "isDone": isDone
    };
  }

  // Creates a milestone model from a map.
  factory MilestoneModel.fromMap(Map<String, dynamic> map) {
    return MilestoneModel(
      docID: map["docID"] != null ? map['docID'] as String : null,
      titleMilestone: map["titleMilestone"] as String,
      description: map["description"] as String,
      level: map["level"] as String,
      dateMilestone: map["dateMilestone"] as String,
      timeMilestone: map["timeMilestone"] as String,
      isDone: map['isDone'] as bool,
    );
  }

  // Creates a milestone model from a Firestore document snapshot.
  factory MilestoneModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return MilestoneModel(
        titleMilestone: doc['titleMilestone'],
        description: doc['description'],
        level: doc['level'],
        dateMilestone: doc['dateMilestone'],
        timeMilestone: doc['timeMilestone'],
        isDone: doc['isDone']);
  }
}