import 'package:flutter/cupertino.dart';
import 'package:flutter_school/constants.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 115,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: myDarkBlue,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: myCream,
            )
          ),
        ),
      ),
    );
  }
}
