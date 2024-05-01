import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_school/models/milestone_model.dart';
import 'package:flutter_school/services/milestone_service.dart';

// Provider for the MilestoneService.
final serviceProvider = StateProvider<MilestoneService>((ref) {
  // Returns a new instance of MilestoneService.
  return MilestoneService();
});

// Provider for the stream of milestones.
final fetchStreamProvider = StreamProvider<List<MilestoneModel>>((ref) async* {
  // Fetches the milestones from the Firestore collection 'milestones'.
  final getData = FirebaseFirestore.instance
      .collection('milestones')
      .snapshots()
      .map((event) => event.docs
          // Maps each document snapshot to a MilestoneModel.
          .map((snapshot) => MilestoneModel.fromSnapshot(snapshot))
          .toList());
  // Yields the stream of milestones.
  yield* getData;
});