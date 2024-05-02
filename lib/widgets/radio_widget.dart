import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/radio_provider.dart';

// RadioWidget is a consumer widget that displays a radio button
class RadioWidget extends ConsumerWidget {
  // titleRadio is the title of the radio button
  // categColor is the color of the radio button
  // valueInput is the value of the radio button
  // onChangeValue is the function that is called when the radio button is changed
  final String titleRadio;
  final Color categColor;
  final int valueInput;
  final VoidCallback onChangeValue;

  // Constructor
  const RadioWidget({
    super.key,
    required this.titleRadio,
    required this.categColor,
    required this.valueInput,
    required this.onChangeValue,
  });

  // Build method
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch the radio button state
    final radio = ref.watch(radioProvider);
    return Material(
      child: Theme(
        data: ThemeData(unselectedWidgetColor: categColor),
        child: RadioListTile(
          // Set the active color of the radio button
          activeColor: categColor,
          // Remove any padding from the radio button
          contentPadding: EdgeInsets.zero,
          // Display the title of the radio button
          title: Transform.translate(
              offset: Offset(-22, 0),
              child: Text(titleRadio,
                  style: TextStyle(
                      color: categColor, fontWeight: FontWeight.w700))),
          // Set the value of the radio button
          value: valueInput,
          // Set the group value of the radio button
          groupValue: radio,
          // Call the onChangeValue function when the radio button is changed
          onChanged: (value) => onChangeValue(),
        ),
      ),
    );
  }
}