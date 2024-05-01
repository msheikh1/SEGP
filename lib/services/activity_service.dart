import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_school/models/activity_model.dart';

class ActivityService {
  final activityCollection = FirebaseFirestore.instance.collection('activity');

  // CREATE
  void addNewActivity(ActivityModel model) {
    activityCollection.add(model.toMap());
  }
  //READ
}