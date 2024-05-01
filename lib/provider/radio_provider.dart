import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for the radio button state.
final radioProvider = StateProvider<int>((ref) {
  // Returns the initial state of the radio button (0 by default).
  return 0;
});