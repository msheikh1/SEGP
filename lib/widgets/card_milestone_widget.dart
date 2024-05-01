import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../provider/service_provider.dart';

// CardMilestoneWidget is a consumer widget that displays a milestone card
class CardMilestoneWidget extends ConsumerWidget {
  // getIndex is the index of the milestone in the list
  final int getIndex;

  // Constructor
  const CardMilestoneWidget({
    super.key,
    required this.getIndex,
  });

  // Build method
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch the milestone data
    final milestoneData = ref.watch(fetchStreamProvider);
    return milestoneData.when(
        data: (milestoneData) {
          Color levelColor = Colors.white;

          // Get the level of the milestone
          final getLevel = milestoneData[getIndex].level;

          // Set the color of the level based on its value
          switch (getLevel) {
            case '1':
              levelColor = Color(0xff023020);
              break;
            case '2':
              levelColor = Colors.green;
              break;
            case '3':
              levelColor = Color(0xffFFD580);
              break;
            case '4':
              levelColor = Color(0xffFF5733);
              break;
            case '5':
              levelColor = Color(0xffb90e0a);
              break;
          }
          // Return a container that represents a milestone card
          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: 6,
            ),
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Display a colored bar that represents the level of the milestone
                Container(
                  decoration: BoxDecoration(
                      color: levelColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  width: 20,
                ),
                // Display the details of the milestone
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: IconButton(
                              icon: Icon(Icons.delete),
                              iconSize: 12,
                              // Call the deleteMilestone function when the delete button is pressed
                              onPressed: () => ref
                                  .read(serviceProvider)
                                  .deleteMilestone(
                                      milestoneData[getIndex].docID),
                            ),
                            title: Text(
                              milestoneData[getIndex].titleMilestone,
                              style: TextStyle(
                                  decoration: milestoneData[getIndex].isDone
                                      ? TextDecoration.lineThrough
                                      : null),
                            ),
                            subtitle: Text(
                              maxLines: 1,
                              milestoneData[getIndex].description,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  decoration: milestoneData[getIndex].isDone
                                      ? TextDecoration.lineThrough
                                      : null),
                            ),
                            trailing: Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                activeColor: Colors.blue.shade800,
                                shape: const CircleBorder(),
                                value: milestoneData[getIndex].isDone,
                                // Call the updateMilestone function when the checkbox is toggled
                                onChanged: (value) {
                                  ref.read(serviceProvider).updateMilestone(
                                      milestoneData[getIndex].docID, value);
                                },
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0, -12),
                            child: Container(
                              child: Column(
                                children: [
                                  Divider(
                                    thickness: 1.5,
                                    color: Colors.grey.shade200,
                                  ),
                                  Row(
                                    children: [
                                      Text('Today'),
                                      Gap(12),
                                      Text(
                                          milestoneData[getIndex].timeMilestone)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ]),
                  ),
                )
              ],
            ),
          );
        },
        error: (error, stackTrace) => Center(
              child: Text(stackTrace.toString()),
            ),
        loading: () => Center(
              child: CircularProgressIndicator(),
            ));
  }
}