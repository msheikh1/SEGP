import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../provider/service_provider.dart';

class CardMilestoneWidget extends ConsumerWidget {
  const CardMilestoneWidget({
    super.key, required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final milestoneData = ref.watch(fetchStreamProvider);
    return milestoneData.when(
        data: (milestoneData) => Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(milestoneData[getIndex].titleMilestone),
                      subtitle: Text(
                        milestoneData[getIndex].description,
                        style: TextStyle(
                            color: Colors.grey, fontSize: 14),
                      ),
                      trailing: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                              activeColor: Colors.blue.shade800,
                              shape: const CircleBorder(),
                              value: milestoneData[getIndex].isDone,
                              onChanged: (value) => print(value))),
                    ),
                    Transform.translate(
                      offset: Offset(0, -12),
                      child: Container(child: Column(
                        children: [
                          Divider(
                            thickness: 1.5,
                            color: Colors.grey.shade200,
                          ),
                          Row(
                            children: [
                              Text('Today'),
                              Gap(12),
                              Text(milestoneData[getIndex].timeMilestone)
                            ],
                          )
                        ],
                      ),),
                    )

                  ]),
            ),
          )
        ],
      ),
    ),
        error: (error, stackTrace) =>
            Center(
              child: Text(stackTrace.toString()),
            ),
        loading: () =>
            Center(
              child: CircularProgressIndicator(),
            ));
  }
}


