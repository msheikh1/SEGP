import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_school/services/activity_service.dart';

// Provider for the ActivityService.
final serviceProvider = StateProvider<ActivityService>((ref) {
  // Returns a new instance of ActivityService.
  return ActivityService();
});