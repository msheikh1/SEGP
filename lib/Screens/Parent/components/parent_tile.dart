import 'package:flutter/material.dart';

import '../../../constants.dart';

class ParentTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const ParentTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: myCream,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            //Icon
            const Icon(Icons.person),

            const SizedBox(width: 20),

            //UserName
            Text(text),
          ],
        ),
      ),
    );
  }
}
