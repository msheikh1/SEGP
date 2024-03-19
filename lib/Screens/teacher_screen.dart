import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_school/Screens/Teacher/add_task_bar.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/main.dart';
import 'package:flutter_school/widgets/app_large_text.dart';
import 'package:flutter_school/widgets/app_text.dart';
import 'package:flutter_school/widgets/button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({Key? key}) : super(key: key);

  @override
  TeacherScreenState createState() => TeacherScreenState();
}

class TeacherScreenState extends State<TeacherScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _topNavigationBar(),
        SizedBox(
          height: 40,
        ),
        _topHeadingBar(),
        SizedBox(
          height: 20,
        ),
        _addTaskBar(),
        SizedBox(
          height: 20,
        ),
        _addDateBar(),
      ],
    ));
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: myDarkBlue,
        selectedTextColor: myCream,
        dateTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        dayTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        monthTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLargeText(
                    text: DateFormat.yMMMMd().format(DateTime.now()), size: 20),
                AppText(text: 'Today', size: 20)
              ],
            ),
          ),
          MyButton(label: "+ Add Task", onTap: () => Get.to(AddTaskPage()))
        ],
      ),
    );
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

  _topHeadingBar() {
    return Container(
        margin: const EdgeInsets.only(left: 20),
        child: AppLargeText(text: "Welcome Teacher Waleed"));
  }
}
