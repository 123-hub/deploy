import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_chat_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/client_back_app_bar.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/client_empty_screen.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/contractor_chat_screen.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/chat_card.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/job_search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContractorConversationScreen extends StatelessWidget {
  ContractorConversationScreen({super.key});
  final searchTextController = TextEditingController();
  final contractorChatController = Get.find<ContractorChatController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 33.w),
      child: Obx(
        () {
          return contractorChatController.allRooms.isEmpty
              ? const ClientEmptyScreen(
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
                      ContractorBackAppBar(),
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
                          itemCount: contractorChatController.allRooms.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ChatCard(
                              room: contractorChatController.allRooms[index],
                              isContractor: true,
                              onTap: () {
                                debugPrint('Clicked');
                                Get.to(
                                  () => ContractorChatScreen(
                                    room: contractorChatController
                                        .allRooms[index],
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
