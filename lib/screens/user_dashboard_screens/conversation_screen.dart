import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/labour_chat_controller.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/back_appbar.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/chat_card.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/empty_screen.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_search_bar.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/labour_chat_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConversationScreen extends StatelessWidget {
  ConversationScreen({super.key});
  final searchTextController = TextEditingController();
  final labourChatController = Get.find<LabourChatController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 33.w),
      child: Obx(
        () {
          return labourChatController.allRooms.isEmpty
              ? const EmptyScreen(
                  image: 'assets/images/empty_jobs.png',
                  title: 'No Conversations Yet',
                  subtitle: 'Wait till a contractor contacts you',
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      BackAppBar(),
                      SizedBox(
                        height: 27.h,
                      ),
                      JobSearchBar(
                        searchTextController: searchTextController,
                        onTap: () {},
                        readOnly: false,
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                      Obx(() {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: labourChatController.allRooms.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ChatCard(
                              room: labourChatController.allRooms[index],
                              isContractor: false,
                              onTap: () {
                                debugPrint('Clicked');
                                Get.to(
                                  () => LabourChatScreen(
                                    room: labourChatController.allRooms[index],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      })
                    ],
                  ),
                );
        },
      ),
    );
  }
}
