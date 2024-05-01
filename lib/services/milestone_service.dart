// Import necessary packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_school/models/milestone_model.dart';

// MilestoneService is a class that provides milestone functionality
class MilestoneService {
  // Get a reference to the 'milestones' collection in Firestore
  final milestoneCollection =
      FirebaseFirestore.instance.collection('milestones');

  // Function to add a new milestone
  // The milestone data is converted to a map before being added to Firestore
  void addNewMilestone(MilestoneModel model) {
    milestoneCollection.add(model.toMap());
  }

  // Function to update a milestone
  // The document ID and the new value for 'isDone' are required
  void updateMilestone(String? docID, bool? valueUpdate) {
    milestoneCollection.doc(docID).update({
      'isDone': valueUpdate,
    });
  }

  // Function to delete a milestone
  // The document ID is required
  void deleteMilestone(String? docID) {
    milestoneCollection.doc(docID).delete();
  }
}