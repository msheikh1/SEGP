import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topNavigationBar(),

        ],

      )
    );
  }

  _topNavigationBar() {
    return Container (
        padding: const EdgeInsets.only(top: 50, left: 20),
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
              margin: const EdgeInsets.only(right: 20),
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
