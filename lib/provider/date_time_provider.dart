import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for the current date.
final dateProvider = StateProvider<String>((ref) {
  // Returns the current date in 'dd/mm/yy' format.
  return 'dd/mm/yy';
});

// Provider for the current time.
final timeProvider = StateProvider<String>((ref) {
  // Returns the current time in 'hh : mm' format.
  return 'hh : mm';
});