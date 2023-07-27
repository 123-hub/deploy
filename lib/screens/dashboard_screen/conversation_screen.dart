import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/screens/dashboard_screen/components/back_appbar.dart';
import 'package:flutter_project_labour_app/screens/dashboard_screen/components/chat_card.dart';
import 'package:flutter_project_labour_app/screens/dashboard_screen/components/job_search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConversationScreen extends StatelessWidget {
  ConversationScreen({super.key});
  final searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 33.w),
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
            JobSearchBar(searchTextController: searchTextController),
            SizedBox(
              height: 17.h,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return const ChatCard();
              },
            )
          ],
        ),
      ),
    );
  }
}
