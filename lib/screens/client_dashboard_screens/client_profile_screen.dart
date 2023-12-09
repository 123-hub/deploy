import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_dashboard_controller.dart';
import 'package:flutter_project_labour_app/controllers/contractor_job_controller.dart';
import 'package:flutter_project_labour_app/controllers/contractor_profile_controller.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/client_back_app_bar.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/contractor_profile_document_card.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/update_company_details_popup.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/update_contractor_details_popup.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/helper_screens/contractor_update_document_screen.dart';
import 'package:flutter_project_labour_app/screens/common/company_info_tile.dart';
import 'package:flutter_project_labour_app/screens/login_screens/login_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/parce_date.dart';
import 'package:flutter_project_labour_app/util/storage_access.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientProfileScreen extends StatelessWidget {
  ClientProfileScreen({super.key});
  final profileController = Get.find<ContractorProfileController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 33.w),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              ContractorBackAppBar(),
              SizedBox(
                height: 30.h,
              ),
              CircleAvatar(
                radius: 48.r,
                backgroundImage:
                    const AssetImage('assets/images/profile_2.png'),
              ),
              SizedBox(
                height: 26.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${profileController.contractorProfile.value!.firstName} ${profileController.contractorProfile.value!.lastName}',
                    style: gilroy18sp,
                  ),
                  IconButton(
                    onPressed: () {
                      updateContractorDetailsPopUp(context, profileController);
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 20.h,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                profileController.contractorProfile.value!.email,
                style: chatTileMessage,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.cake,
                    size: 15.h,
                    color: cardSubtitle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    parceDate(
                        profileController.contractorProfile.value!.dateOfBirth),
                    style: subtitle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: cardSubtitle,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  const Text(
                    '●',
                    style: TextStyle(color: cardSubtitle),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    profileController.contractorProfile.value!.phoneNumber,
                    style: subtitle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: cardSubtitle,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              const Divider(),
              // SizedBox(
              //   height: 13.h,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Company Info',
                    style: tileHeader.copyWith(color: aboutGrey),
                  ),
                  IconButton(
                    onPressed: () {
                      updateCompanyDetailsPopUp(context, profileController);
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 20.h,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              CompanyInfoTile(
                title: 'Name',
                value: profileController.contractorProfile.value!.companyName,
              ),
              SizedBox(
                height: 13.h,
              ),
              CompanyInfoTile(
                title: 'Website',
                value:
                    profileController.contractorProfile.value!.companyWebsite,
              ),
              SizedBox(
                height: 13.h,
              ),
              CompanyInfoTile(
                title: 'Phone Number',
                value: profileController
                    .contractorProfile.value!.companyPhoneNumber,
              ),
              SizedBox(
                height: 13.h,
              ),
              CompanyInfoTile(
                title: 'Address',
                value:
                    profileController.contractorProfile.value!.companyAddress,
              ),
              SizedBox(
                height: 13.h,
              ),
              CompanyInfoTile(
                title: 'Fax Number',
                value:
                    profileController.contractorProfile.value!.companyFaxNumber,
              ),
              SizedBox(
                height: 13.h,
              ),
              CompanyInfoTile(
                title: 'License Number',
                value: profileController
                    .contractorProfile.value!.businessLicenseNumber,
              ),
              SizedBox(
                height: 13.h,
              ),
              CompanyInfoTile(
                title: 'WCB Number',
                value: profileController.contractorProfile.value!.wcbNumber,
              ),
              SizedBox(
                height: 30.h,
              ),
              const Divider(),
              // SizedBox(
              //   height: 15.h,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Documents',
                    style: tileHeader.copyWith(color: aboutGrey),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(() => ContractorUpdateDocumentScreen());
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 20.h,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              profileController.contractorProfile.value!.documents.isEmpty
                  ? Text(
                      'No Documents Added',
                      style: tileHeader.copyWith(
                        color: subtitleGrey,
                        fontSize: 12.sp,
                      ),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: profileController
                          .contractorProfile.value!.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ContractorProfileDocumentCard(
                          document: profileController
                              .contractorProfile.value!.documents[index],
                        );
                      },
                    ),
              SizedBox(
                height: 15.h,
              ),
              const Divider(),
              // Text(
              //   'Recently Hired',
              //   style: tileHeader.copyWith(color: aboutGrey),
              // ),
              // SizedBox(
              //   height: 22.h,
              // ),
              // Row(
              //   children: [
              //     Column(
              //       children: [
              //         CircleAvatar(
              //           backgroundImage:
              //               const AssetImage('assets/images/worker.png'),
              //           radius: 30.r,
              //         ),
              //         Text('Mason Baxter',
              //             style: gilroy12_600.copyWith(color: aboutGrey)),
              //       ],
              //     ),
              //     SizedBox(
              //       width: 25.w,
              //     ),
              //     Column(
              //       children: [
              //         CircleAvatar(
              //           backgroundImage:
              //               const AssetImage('assets/images/worker.png'),
              //           radius: 30.r,
              //         ),
              //         Text('Mason Baxter',
              //             style: gilroy12_600.copyWith(color: aboutGrey)),
              //       ],
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: 15.h,
              // ),
              TextButton(
                onPressed: () {
                  Get.delete<ContractorProfileController>(force: true);
                  Get.delete<ContractorJobController>(force: true);
                  Get.delete<ContractorDashboardController>(force: true);
                  StorageAccess.deleteValues();
                  Get.offAll(() => LoginScreen());
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      color: primaryRed,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'Log out',
                      style: gilroy16sp.copyWith(color: primaryRed),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
            ],
          );
        }),
      ),
    );
  }
}
