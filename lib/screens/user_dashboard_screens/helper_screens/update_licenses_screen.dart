import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/labour_profile_controller.dart';
import 'package:flutter_project_labour_app/screens/common/progress_hud.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/labour_license_card.dart';
import 'package:flutter_project_labour_app/screens/user_dashboard_screens/components/add_profile_license_popup.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdateLicenseScreen extends StatelessWidget {
  UpdateLicenseScreen({super.key});
  final profileController = Get.find<LabourProfileController>();
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
                      return profileController.licenses.isEmpty
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.80,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  'Add Licenses to show here',
                                  style: authHeading,
                                ),
                              ),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: profileController.licenses.length,
                              itemBuilder: (BuildContext context, int index) {
                                var lic = profileController.licenses[index];
                                return LabourLicenseCard(
                                  license: lic.toModel(),
                                  onTap: () {
                                    addProfileLicensePopUp(
                                      context,
                                      profileController,
                                      license:
                                          profileController.licenses[index],
                                    );
                                  },
                                  onDelete: () async {
                                    if (profileController
                                            .licenses[index].id !=
                                        0) {
                                      var deleted =
                                          await profileController.deleteItem(
                                        "licenses",
                                        profileController.licenses[index].id!,
                                      );
                                      if (deleted) {
                                        profileController.deleteLicense(lic);
                                      } else {
                                        showErrorSnackBar(
                                          "Error Deleting document",
                                        );
                                      }
                                    } else {
                                      profileController.deleteLicense(lic);
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
              var labour = profileController.labourProfile.value!.copy();
              labour.licenses = profileController.licenses;
              var result = await profileController.updateProfileValues(labour);
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
              addProfileLicensePopUp(context, profileController);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
