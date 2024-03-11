import 'package:flutter/material.dart';
import 'package:flutter_school/widgets/app_large_text.dart';
import 'package:get/get.dart';

import '../../widgets/input_field.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topNavigationBar(),
            SizedBox(height: 20,),
            AppLargeText(text: "Add Task"),
            MyInputField(title: "Title", hint: "Enter your title"),
            MyInputField(title: "Note", hint: "Enter your note"),
          ],

      ),
        ),
      )
    );
  }

  _topNavigationBar() {
    return Container (
        padding: const EdgeInsets.only(top: 50),
        child: Row(

          children: [
            GestureDetector(
              onTap: () {
                Get.back();
;              },
              child: Icon(Icons.arrow_back),
            ),
            Expanded(child: Container()),
            Container(
              width: 50,
              height: 50,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.5),
              ),
            )
          ],
        )
    );
  }
}
