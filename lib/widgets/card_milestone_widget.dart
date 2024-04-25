import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardMilestoneWidget extends StatelessWidget {
  const CardMilestoneWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      title: Text('Motor Skills Level 1'),
                      subtitle: Text(
                        'Key Stage one early year development',
                        style: TextStyle(
                            color: Colors.grey, fontSize: 14),
                      ),
                      trailing: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                              activeColor: Colors.blue.shade800,
                              shape: const CircleBorder(),
                              value: true,
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
                              Text('09:15 AM - 11:45 PM')
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
    );
  }
}