import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_school/models/milestone_model.dart';
import 'package:flutter_school/services/milestone_service.dart';

final serviceProvider = StateProvider<MilestoneService>((ref) {
  return MilestoneService();
});

final fetchStreamProvider = StreamProvider<List<MilestoneModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('milestones')
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => MilestoneModel.fromSnapshot(snapshot))
          .toList());
  yield* getData;
});
