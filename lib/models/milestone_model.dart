import 'package:cloud_firestore/cloud_firestore.dart';

class MilestoneModel {
  String? docID;
  final String titleMilestone;
  final String description;
  final String level;
  final String dateMilestone;
  final String timeMilestone;
  final bool isDone;

  MilestoneModel(
      {this.docID,
      required this.titleMilestone,
      required this.description,
      required this.level,
      required this.dateMilestone,
      required this.timeMilestone,
      required this.isDone});

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
