import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:flutter_school/Screens/Teacher/chat_page.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/services/chat/chat_service.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../widgets/app_large_text.dart';
import 'package:flutter_school/Screens/Teacher/components/parent_tile.dart';

class Milestones extends StatefulWidget {
  final Function(String, String, int) onStudentTap;

  const Milestones({Key? key, required this.onStudentTap}) : super(key: key);

  @override
  MilestonesState createState() => MilestonesState();
}

class MilestonesState extends State<Milestones> {
  int _index = 0;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topNavigationBar(),
          SizedBox(
            height: 25,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: AppLargeText(text: "Milestones"),
          ),
          _milestoneCard(),

        ], // Added closing bracket for Column children
      ),
    );
  }

}

_topNavigationBar() {
  return Container(
      padding: const EdgeInsets.only(top: 50, left: 20),
      child: Row(
        children: [
          Icon(Icons.menu, size: 30, color: Colors.black54),
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
      ));
}

_milestoneCard() {
  return Padding(
    padding: EdgeInsets.only(
      left: 18,
      right: 18,
      top: 18,
      bottom: 18,
    ),
    child: GestureDetector(
      onTap: () {},
      child: Container(
        width: 380,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.quiz,
                size: 25,
                color: myDarkBlue,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 30,
                      left: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 6,
                          ),
                          child: Container(
                            width: 225,
                            height: 30,
                            child: FittedBox(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Child',
                                maxLines: 1,
                                style: const TextStyle(
                                  color: Colors.white10,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 6,
                          ),
                          child: Text(
                            'subject',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 6,
                          ),
                          child: Text(
                            'Class',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
