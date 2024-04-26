import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_school/models/milestone_model.dart';

class MilestoneService {
  final milestoneCollection = FirebaseFirestore.instance.collection('milestones');

  //CRUD

  //CREATE
  void addNewMilestone(MilestoneModel model){
    milestoneCollection.add(model.toMap());
  }

  //UPDATE
  void updateMilestone(String? docID, bool? valueUpdate) {
    milestoneCollection.doc(docID).update({
      'isDone' : valueUpdate,
    });
  }

  //DELETE
  void deleteMilestone(String? docID) {
    milestoneCollection.doc(docID).delete();
  }

}