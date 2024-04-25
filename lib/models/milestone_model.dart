import 'package:cloud_firestore/cloud_firestore.dart';

class MilestoneModel {
  String? docID;
  final String titleTask;
  final String description;
  final String level;
  final String dateMilestone;
  final String timeMilestone;

  MilestoneModel(
      {this.docID,
      required this.titleTask,
      required this.description,
      required this.level,
      required this.dateMilestone,
      required this.timeMilestone});

  Map<String, dynamic> toJson() {
    return {
      "docID": this.docID,
      "titleTask": this.titleTask,
      "description": this.description,
      "level": this.level,
      "dateTask": this.dateMilestone,
      "timeTask": this.timeMilestone,
    };
  }

  factory MilestoneModel.fromJson(Map<String, dynamic> json) {
    return MilestoneModel(
      docID: json["docID"],
      titleTask: json["titleTask"],
      description: json["description"],
      level: json["level"],
      dateMilestone: json["dateTask"],
      timeMilestone: json["timeTask"],
    );
  }

  factory MilestoneModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return MilestoneModel(
        docID: doc.id,
        titleTask: doc['titleMilestone'],
        description: doc['description'],
        level: doc['level'],
        dateMilestone: doc['dateMilestone'],
        timeMilestone: doc['timeMilestone']);
  }
}
