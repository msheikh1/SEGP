import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../constants.dart';

// DateTimeWidget is a consumer widget that displays a date and time widget
class DateTimeWidget extends ConsumerWidget {
  // titleText is the title of the widget
  // valueText is the value of the widget
  // iconSection is the icon of the widget
  // onTap is the function that is called when the widget is tapped
  final String titleText;
  final String valueText;
  final IconData iconSection;
  final VoidCallback onTap;

  // Constructor
  const DateTimeWidget({
    super.key,
    required this.titleText,
    required this.valueText,
    required this.iconSection,
    required this.onTap,
  });

  // Build method
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the title text
          Text(titleText, style: appStyle),
          Material(
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                // Call the onTap function when the widget is tapped
                onTap: () => onTap(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    // Display the icon and value text
                    children: [Icon(iconSection), Gap(6), Text(valueText)],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}