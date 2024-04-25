import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_school/models/milestone_model.dart';

class MilestoneService {
  final milestoneCollection = FirebaseFirestore.instance.collection('milestones');

  //CRUD

  //CREATE
  void addNewMilestone(MilestoneModel model){
    milestoneCollection.add(model.toMap());
  }

}