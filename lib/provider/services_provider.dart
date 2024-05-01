import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_school/services/activity_service.dart';

final serviceProvider = StateProvider<ActivityService>((ref) {
  return ActivityService() ;
});
