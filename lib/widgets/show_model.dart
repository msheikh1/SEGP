import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_school/constants.dart';
import 'package:flutter_school/models/milestone_model.dart';
import 'package:flutter_school/widgets/radio_widget.dart';
import 'package:flutter_school/widgets/text_field.dart';

import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../provider/date_time_provider.dart';
import '../provider/radio_provider.dart';
import '../provider/service_provider.dart';
import 'date_time_widget.dart';

final titleControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final descriptionControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());

class AddNewTaskModel extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = ref.watch(titleControllerProvider);
    final descriptionController = ref.watch(descriptionControllerProvider);
    final dateProv = ref.watch(dateProvider);
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              'New Milestone',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade200,
          ),
          Gap(12),
          Text('Milestone Title', style: appStyle),
          Gap(6),
          TextInputWidget(
            hintText: 'Add Milestone',
            maxLine: 1,
            txtController: titleController,
          ),
          Gap(14),
          Text('Description', style: appStyle),
          TextInputWidget(
            hintText: 'Add Descriptions',
            maxLine: 5,
            txtController: descriptionController,
          ),
          Gap(12),
          Text(
            'Difficulty Level',
            style: appStyle,
          ),
          Row(
            children: [
              Expanded(
                child: RadioWidget(
                  titleRadio: '1',
                  categColor: Color(0xff023020),
                  valueInput: 1,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 1),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: '2',
                  categColor: Colors.green,
                  valueInput: 2,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 2),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: '3',
                  categColor: Color(0xffFFD580),
                  valueInput: 3,
                  onChangeValue: () => ref.read(radioProvider.notifier).update(
                        (state) => 3,
                      ),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: '4',
                  categColor: Color(0xffFF5733),
                  valueInput: 4,
                  onChangeValue: () => ref.read(radioProvider.notifier).update(
                        (state) => 4,
                      ),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: '5',
                  categColor: Color(0xffb90e0a),
                  valueInput: 5,
                  onChangeValue: () => ref.read(radioProvider.notifier).update(
                        (state) => 5,
                      ),
                ),
              ),
            ],
          ),

          //Date and Time Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimeWidget(
                titleText: 'Date',
                valueText: dateProv,
                iconSection: Icons.calendar_month_outlined,
                onTap: () async {
                  final getValue = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2027));

                  if (getValue != null) {
                    final format = DateFormat.yMd();
                    ref
                        .read(dateProvider.notifier)
                        .update((state) => format.format(getValue));
                  }
                },
              ),
              Gap(22),
              DateTimeWidget(
                titleText: 'Time',
                valueText: ref.watch(timeProvider),
                iconSection: Icons.watch_later_outlined,
                onTap: () async {
                  final getTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (getTime != null) {
                    ref
                        .read(timeProvider.notifier)
                        .update((state) => getTime.format(context));
                  }
                },
              )
            ],
          ),

          //Button Section
          Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimeWidget(
                titleText: 'Date',
                valueText: dateProv,
                iconSection: Icons.calendar_month_outlined,
                onTap: () async {
                  final getValue = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2027),
                  );

                  if (getValue != null) {
                    final format = DateFormat.yMd();
                    ref
                        .read(dateProvider.notifier)
                        .update((state) => format.format(getValue));
                  }
                },
              ),
              Gap(22),
              DateTimeWidget(
                titleText: 'Time',
                valueText: ref.watch(timeProvider),
                iconSection: Icons.watch_later_outlined,
                onTap: () async {
                  final getTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (getTime != null) {
                    ref
                        .read(timeProvider.notifier)
                        .update((state) => getTime.format(context));
                  }
                },
              )
            ],
          ),
          // Button Section
          Gap(12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: Colors.blue.shade800,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
              ),
              Gap(20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: Colors.blue.shade800,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    final getRadioValue = ref.read(radioProvider);
                    String level = '';

                    switch (getRadioValue) {
                      case 1:
                        level = '1';
                        break;
                      case 2:
                        level = '2';
                        break;
                      case 3:
                        level = '3';
                        break;
                      case 4:
                        level = '4';
                        break;
                      case 5:
                        level = '5';
                        break;
                    }

                    ref.read(serviceProvider).addNewMilestone(MilestoneModel(
                          titleMilestone: titleController.text,
                          description: descriptionController.text,
                          level: level,
                          dateMilestone: ref.read(dateProvider),
                          timeMilestone: ref.read(timeProvider),
                          isDone: false,
                        ));
                    print('Data is saved');
                    titleController.clear();
                    descriptionController.clear();
                    ref.read(radioProvider.notifier).update((state) => 0);
                    Navigator.pop(context);
                  },
                  child: Text('Create'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
