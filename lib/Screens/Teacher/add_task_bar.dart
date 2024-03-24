import 'package:flutter/material.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/widgets/app_large_text.dart';
import 'package:flutter_school/widgets/button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List <int> remindList = [
    5,
    10,
    15,
    20,
  ];

  String _selectedRepeat = "None";
  List <String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];
  int _selectedColor = 0;
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
            MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {
                  print("Hi teh tarik");
                  _getDateFromUser();
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: MyInputField(
                      title: "Start Time",
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: (){
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    )
                ),
                SizedBox(width: 12,),
                Expanded(
                    child: MyInputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: (){
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    )
                )
              ],
            ),
            MyInputField(title: "Remind", hint: "$_selectedRemind minutes early",
              widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down,
                color: Colors.grey,
                ),
                iconSize: 32,
                elevation: 4,
                style: subTitleStyle,
                underline: Container(height: 0,),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRemind = int.parse(newValue!);
                  });
                },
                items: remindList.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
              }
                ).toList(),
              ),
            ),
            MyInputField(title: "Repeat", hint: "$_selectedRepeat",
              widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                iconSize: 32,
                elevation: 4,
                style: subTitleStyle,
                underline: Container(height: 0,),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRepeat = newValue!;
                  });
                },
                items: repeatList.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value!, style: TextStyle(color: Colors.grey)),
                  );
                }
                ).toList(),
              ),
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _colorPalette(),
                MyButton(label: "Create Task", onTap: ()=>null)
              ],
            )
          ],

      ),
        ),
      )
    );
  }

  _colorPalette(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        SizedBox(height: 8,),
        Wrap(
          children: List<Widget>.generate(3, (int index) => GestureDetector(
            onTap: (){
              setState(() {
                _selectedColor = index;
                // print("$index");
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: index==0?myRed:index==1?myRed:myRed,
                child: _selectedColor==index?Icon(Icons.done,
                  color: Colors.white,
                  size: 16,
                ):Container(),
              ),
            ),
          )),
        )
      ],
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

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2222)
    );

    if (_pickerDate!=null){
     setState(() {
       _selectedDate = _pickerDate;
       print(_selectedDate);
     });
    } else{
      print("It's null or something wrong");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formattedTime = pickedTime.format(context);
    if(pickedTime == null){
      print("Time Cancelled");
    } else if (isStartTime == true){
      setState(() {
        _startTime = _formattedTime;
      });
    } else if (isStartTime == false){
      setState(() {
        _endTime = _formattedTime;
      });
    }

  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])
        )
    );
  }
}
