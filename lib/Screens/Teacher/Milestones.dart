import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_school/Screens/Teacher/add_task_bar.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/main.dart';
import 'package:flutter_school/models/classStructure.dart';
import 'package:flutter_school/provider/service_provider.dart';
import 'package:flutter_school/services/database.dart';
import 'package:flutter_school/widgets/app_large_text.dart';
import 'package:flutter_school/widgets/app_text.dart';
import 'package:flutter_school/widgets/button.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';

import '../../widgets/card_milestone_widget.dart';
import '../../widgets/show_model.dart';

class Milestones extends ConsumerWidget {
  final Function(int) onStudentTap;

  const Milestones({Key? key, required this.onStudentTap}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final milestoneData = ref.watch(fetchStreamProvider);
    DatabaseService database = DatabaseService();
    AuthService _auth = AuthService();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Gap(75),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Milestone Section',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text('Assess progress of your Students',
                          style: TextStyle(color: Colors.grey))
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD5E8FA),
                      foregroundColor: Colors.blue.shade800,
                    ),
                    onPressed: () => showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        context: context,
                        builder: (context) => AddNewTaskModel()),
                    child: Text(
                      '+ Add Milestone',
                    ),
                  ),
                ],
              ),
              Gap(40),
              ListView.builder(
                itemCount: milestoneData.value!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    Expanded(child: CardMilestoneWidget(getIndex: index)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
