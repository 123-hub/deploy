import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_signup_screen_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_appbar.dart';
import 'package:flutter_project_labour_app/screens/common/next_button.dart';
import 'package:flutter_project_labour_app/screens/common/progress_hud.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/add_document.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/contractor_add_documents.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/contractor_document_card.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/signup_complete_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContractorDocumentScreen extends StatelessWidget {
  ContractorDocumentScreen({super.key});
  final contractorSignUpScreenController =
      Get.find<ContractorSignUpScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ProgressHud(
          inAsyncCall: contractorSignUpScreenController.isCreatingID.value,
          child: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 37.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          const AuthAppBar(),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            'Documents Details',
                            style: authHeading,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            'Add documents to prove your authenticity',
                            style: subtitle.copyWith(color: subtitleGrey),
                          ),
                          SizedBox(
                            height: 36.h,
                          ),
                          AddDocument(
                            title: 'Add Document',
                            onTap: () {
                              contractorAddDocumentPopup(
                                  context, contractorSignUpScreenController);
                            },
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Obx(() {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: contractorSignUpScreenController
                                  .documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                var doc = contractorSignUpScreenController
                                    .documents[index];
                                return ContractorDocumentCard(
                                  documentModel: doc,
                                  onDelete: () {
                                    contractorSignUpScreenController
                                        .deleteDocument(doc);
                                  },
                                );
                              },
                            );
                          }),
                          SizedBox(
                            height: 30.h,
                          ),
                          SizedBox(
                            height: 100.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30.h,
                    right: 30.w,
                    child: NextButton(
                      text: 'Next',
                      isArrowPresent: true,
                      onPressed: () async {
                        bool success = await contractorSignUpScreenController
                            .contractorSignup();
                        if (success) {
                          Get.delete<ContractorSignUpScreenController>(
                            force: true,
                          );
                          Get.to(() => const SignUpComplete());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
