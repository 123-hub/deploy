import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/models/room.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatelessWidget {
  const ChatCard(
      {super.key,
      required this.room,
      required this.onTap,
      required this.isOrganizer});

  final Room room;
  final bool isOrganizer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 55.h,
            width: double.infinity,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: const AssetImage(
                    'assets/images/profile_1.png',
                  ),
                  radius: 30.r,
                ),
                SizedBox(
                  width: 18.w,
                ),
                Expanded(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isOrganizer
                                  ? room.joinerName
                                  : room.organizerName,
                              style: authInfoHeading,
                            ),
                            Text(
                              DateFormat.Hm().format(room.createdAt),
                              style: subtitle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: timeGrey,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         'Lorem ipsum dolor sit amet, consecutes and hem del la nice caravana sar.',
                        //         style: chatTileMessage,
                        //         overflow: TextOverflow.ellipsis,
                        //       ),
                        //     ),
                        //     const Icon(
                        //       Icons.check,
                        //       color: chatTick,
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          const Divider(),
          SizedBox(
            height: 6.h,
          ),
        ],
      ),
    );
  }
}
