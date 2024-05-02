import 'package:flutter/material.dart';

import '../../../constants.dart';

// This widget represents a tile for a parent.
class ParentTile extends StatelessWidget {
  // The text to be displayed on the tile.
  final String text;
  // The function to be executed when the tile is tapped.
  final void Function()? onTap;

  // Constructor for the ParentTile class.
  const ParentTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Returns a GestureDetector widget that contains a Container widget.
    return GestureDetector(
      // Set the function to be executed when the GestureDetector is tapped.
      onTap: onTap,
      child: Container(
        // Set the decoration for the Container.
        decoration: BoxDecoration(
          color: myCream,
          borderRadius: BorderRadius.circular(12),
        ),
        // Set the margin for the Container.
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        // Set the padding for the Container.
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            // Display an Icon widget.
            const Icon(Icons.person),

            const SizedBox(width: 20),

            // Display the text for the tile.
            Text(text),
          ],
        ),
      ),
    );
  }
}