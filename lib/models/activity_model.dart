import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  String? docID;
  final String titleActivity;
  final String description;
  final String startTime;
  final String endTime;

  ActivityModel(
      {this.docID,
      required this.titleActivity,
      required this.description,
      required this.startTime,
      required this.endTime});

  Map<String, dynamic> toMap() {
    return {
      'docID': this.docID,
      'titleActivity': this.titleActivity,
      'description': this.description,
      'startTime': this.startTime,
      'endTime': this.endTime,
    };
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      titleActivity: map['titleActivity'] as String,
      description: map['description'] as String,
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
    );
  }

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
