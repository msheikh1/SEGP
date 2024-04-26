// import 'package:flutter/material.dart';
// import 'package:flutter_school/Screens/Teacher/teacher_screen.dart';
// import 'package:flutter_school/constants.dart';
// import 'package:flutter_school/models/activity_model.dart';
// import 'package:flutter_school/provider/services_provider.dart';
// import 'package:flutter_school/widgets/app_large_text.dart';
// import 'package:flutter_school/widgets/button.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../widgets/input_field.dart';
//
// class AddTaskPage extends ConsumerWidget {
//
//   const AddTaskPage({super.key});
// }
//
// final titleController = TextEditingController();
// final descriptionController = TextEditingController();
//
// class _AddTaskPageState extends State<AddTaskPage> {
//   DateTime _selectedDate = DateTime.now();
//   String _endTime = "9:30 PM";
//   String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
//   int _selectedRemind = 5;
//   List <int> remindList = [
//     5,
//     10,
//     15,
//     20,
//   ];
//
//   String _selectedRepeat = "None";
//   List <String> repeatList = [
//     "None",
//     "Daily",
//     "Weekly",
//     "Monthly",
//   ];
//   int _selectedColor = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.only(left: 20, right: 20),
//         child: SingleChildScrollView(
//           child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _topNavigationBar(),
//             SizedBox(height: 20,),
//             AppLargeText(text: "Add Activity"),
//             SizedBox(height: 20,),
//             MyInputField(title: "Title", hint: "Enter your activity title", controller: titleController,),
//             SizedBox(height: 20,),
//             MyInputField(title: "Description", hint: "Enter the description of the activity", controller: descriptionController,),
//             SizedBox(height: 20,),
//             MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
//               widget: IconButton(
//                 icon: Icon(
//                   Icons.calendar_today_outlined,
//                   color: Colors.grey,
//                 ),
//                 onPressed: () {
//                   _getDateFromUser();
//                 },
//               ),
//             ),
//             SizedBox(height: 20,),
//             Row(
//               children: [
//                 Expanded(
//                     child: MyInputField(
//                       title: "Start Time",
//                       hint: _startTime,
//                       widget: IconButton(
//                         onPressed: () async {
//                           final getValue = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(2021),
//                             lastDate: DateTime(2027),
//                           );
//
//                           if (getValue != null) {
//                             final format = DateFormat.yMd();
//                             context.read(dateProvider.notifier).update(format.format(getValue));
//                           }
//                         },
//                         icon: Icon(
//                           Icons.access_time_rounded,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     )
//                 ),
//                 SizedBox(width: 12,),
//                 Expanded(
//                     child: MyInputField(
//                       title: "End Time",
//                       hint: _endTime,
//                       widget: IconButton(
//                         onPressed: () async {
//                           final getTime = await showTimePicker(
//                             context: context,
//                             initialTime: TimeOfDay.now(),
//                           );
//                           if (getTime != null) {
//                             context.read(timeProvider.notifier).update(getTime.format(context));
//                           }
//                         },
//                         icon: Icon(
//                           Icons.access_time_rounded,
//                           color: Colors.grey,
//                         ),
//                       ),
//                         icon: Icon(
//                           Icons.access_time_rounded,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     )
//                 )
//               ],
//             ),
//             SizedBox(height: 40),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 MyButton(label: "Create Task", onTap: () {
//                   ref.read(serviceProvider).addNewActivity(
//                     ActivityModel(titleActivity: titleActivity, description: description, startTime: startTime, endTime: endTime)
//                   )
//                 })
//               ],
//             )
//           ],
//
//       ),
//         ),
//       )
//     );
//   }
//
//   _colorPalette(){
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Color",
//           style: titleStyle,
//         ),
//         SizedBox(height: 8,),
//         Wrap(
//           children: List<Widget>.generate(1, (int index) => GestureDetector(
//             onTap: (){
//               setState(() {
//                 _selectedColor = index;
//                 // print("$index");
//               });
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child: CircleAvatar(
//                 radius: 14,
//                 backgroundColor: index==0?myRed:index==1?myRed:myRed,
//                 child: _selectedColor==index?Icon(Icons.done,
//                   color: Colors.white,
//                   size: 16,
//                 ):Container(),
//               ),
//             ),
//           )),
//         )
//       ],
//     );
//   }
//   _topNavigationBar() {
//     return Container(
//       padding: const EdgeInsets.only(top: 50),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(Icons.arrow_back),
//           ),
//           Expanded(child: Container()),
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.grey.withOpacity(0.5),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//
//   _getDateFromUser() async {
//     DateTime? _pickerDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2015),
//         lastDate: DateTime(2222)
//     );
//
//     if (_pickerDate!=null){
//      setState(() {
//        _selectedDate = _pickerDate;
//        print(_selectedDate);
//      });
//     } else{
//       print("It's null or something wrong");
//     }
//   }
//
//   _getTimeFromUser({required bool isStartTime}) async {
//     var pickedTime = await _showTimePicker();
//     String _formattedTime = pickedTime.format(context);
//     if(pickedTime == null){
//       print("Time Cancelled");
//     } else if (isStartTime == true){
//       setState(() {
//         _startTime = _formattedTime;
//       });
//     } else if (isStartTime == false){
//       setState(() {
//         _endTime = _formattedTime;
//       });
//     }
//
//   }
//
//   _showTimePicker() {
//     return showTimePicker(
//         initialEntryMode: TimePickerEntryMode.input,
//         context: context,
//         initialTime: TimeOfDay(
//             hour: int.parse(_startTime.split(":")[0]),
//             minute: int.parse(_startTime.split(":")[1].split(" ")[0])
//         )
//     );
//   }
// }
