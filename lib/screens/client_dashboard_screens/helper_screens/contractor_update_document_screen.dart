import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_profile_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/add_contractor_profile_document_popup.dart';
import 'package:flutter_project_labour_app/screens/common/progress_hud.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/contractor_document_card.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContractorUpdateDocumentScreen extends StatelessWidget {
  ContractorUpdateDocumentScreen({super.key});
  final profileController = Get.find<ContractorProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return ProgressHud(
            inAsyncCall: profileController.isUpdating.value,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 33.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                        Image.asset(
                          'assets/images/notification.png',
                          height: 25.h,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Obx(() {
                      return profileController.documents.isEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.80,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  'Add Documents to show here',
                                  style: authHeading,
                                ),
                              ),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: profileController.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                var doc = profileController.documents[index];
                                return ContractorDocumentCard(
                                  documentModel: doc.toModel(),
                                  onTap: () {
                                    addContractorProfileDocument(
                                      context,
                                      profileController,
                                      document:
                                          profileController.documents[index],
                                    );
                                  },
                                  onDelete: () async {
                                    if (profileController.documents[index].id !=
                                        0) {
                                      var deleted =
                                          await profileController.deleteItem(
                                        "documents",
                                        profileController.documents[index].id!,
                                      );
                                      if (deleted) {
                                        profileController.deleteDocument(doc);
                                      } else {
                                        showErrorSnackBar(
                                          "Error Deleting document",
                                        );
                                      }
                                    } else {
                                      profileController.deleteDocument(doc);
                                    }
                                  },
                                );
                              },
                            );
                    }),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              profileController.isUpdating(true);
              var contractor =
                  profileController.contractorProfile.value!.copy();
              contractor.documents = profileController.documents;
              var result =
                  await profileController.updateProfileValue(contractor);
              profileController.isUpdating(false);
              if (result) {
                Get.back();
              } else {
                showErrorSnackBar("Some Problem occurred");
              }
            },
            child: const Icon(Icons.save),
          ),
          SizedBox(
            width: 20.w,
          ),
          FloatingActionButton(
            heroTag: 'Add',
            onPressed: () {
              addContractorProfileDocument(context, profileController);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
