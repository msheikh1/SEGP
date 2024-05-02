import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/constants.dart';
import 'package:get/get.dart';

// MyInputField is a stateless widget that displays an input field
class MyInputField extends StatelessWidget {
  // title is the title of the input field
  // hint is the hint text displayed in the input field
  // controller is the controller for the input field
  // widget is an optional widget that can be displayed inside the input field
  final String? title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  // Constructor
  MyInputField({
    Key? key,
    this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  // Build method
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Conditionally render the title if it's provided
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          Container(
            height: 52,
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    // Make the input field read-only if a widget is provided
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor: Colors.grey[700],
                    controller: controller,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subTitleStyle,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                // Conditionally render the widget if it's provided
                if (widget != null) Container(child: widget),
              ],
            ),
          )
        ],
      ),
    );
  }
}