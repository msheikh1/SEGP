import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_school/constants.dart';


class TeacherScreen extends StatefulWidget {
  const TeacherScreen({Key? key}) : super(key: key);

  @override
  State<TeacherScreen> createState() => _ProfileState();
}

class _ProfileState extends State<TeacherScreen> {
  File? image;

  final ImagePicker _picker = ImagePicker();

  Future pickImage(ImageSource? source) async {
    final XFile? myImage = await _picker.pickImage(source: source!);
    setState(() {
      if (myImage != null) {
        image = File(myImage.path);
      } else {
        print("pick Image");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: SafeArea(

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:16.0),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                const SizedBox(height:54,),
                Column(
                    children: [
                      Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                  radius:48,
                                  child:Image.asset(
                                    'assets/profile.png',
                                    fit: BoxFit.cover,
                                  )
                              ),
                              Positioned(
                                bottom:0,
                                right:5,
                                child: InkWell(
                                  onTap:(){
                                    pickImage(ImageSource.gallery);
                                  },
                                  child: Container(height:26,width:26,
                                    decoration:BoxDecoration(
                                      borderRadius:BorderRadius.circular(100),
                                      color:Colors.grey,
                                      border:Border.all(color:Colors.white,width:1),
                                    ),
                                    child:const Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Icon(Icons.camera_alt_outlined,color:Colors.white,size:14,)
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height:8,),
                      const Text('Andrew Johns',style:TextStyle(fontWeight:FontWeight.w700,fontSize:16),),
                      const SizedBox(height:0,),
                      const Text( "Member Since 2022",),

                    ]),
                const Text('Occupation',style:TextStyle(fontWeight:FontWeight.w700,fontSize:16),),
                const Text( "Lorem ipsum dolor sit amet consectetur. Sed arcu ultrices nullam egestas tortor ultrices."
                    " Ullamcorper enim scelerisque urna consectetur orci a morbi.",),
                const SizedBox(height:18,),
                const Text('Email',style:TextStyle(fontWeight:FontWeight.w700,fontSize:16),),
                const Text( "test@gmail.com",),
                const SizedBox(height:18,),
                const Text('Phone Number',style:TextStyle(fontWeight:FontWeight.w700,fontSize:16),),
                const Text( "01000919626",),
                const SizedBox(height:58,),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Column(children: [
                      _customButton(title: "Change Password"),
                      const SizedBox(height:18,),
                      _customButton(title: "Bio"),
                      const SizedBox(height:18,),
                      _customButton(title: "Log Out"),
                    ],)
                  ],)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customButton({required String title}){
    return Container(
      height:44,
      width:240,
      decoration:BoxDecoration(
        borderRadius:BorderRadius.circular(20),
        color:myDarkBlue,
      ),
      child:Center(child: Text(title,style:const TextStyle(fontWeight:FontWeight.w700,fontSize:16,color:myCream))),
    );
  }
}
