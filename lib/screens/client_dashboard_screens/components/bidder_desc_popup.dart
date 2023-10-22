import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_job_controller.dart';
import 'package:flutter_project_labour_app/models/bidder.dart';
import 'package:flutter_project_labour_app/screens/client_dashboard_screens/components/contractor_profile_document_card.dart';
import 'package:flutter_project_labour_app/screens/common/company_info_tile.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/parce_date.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<dynamic> bidderDescriptionPopUp(
  BuildContext context,
  Bidder profile,
  int jobId,
  ContractorJobController contractorJobController,
) {
  // final chatController = Get.find<ContractorChatController>();
  return showModalBottomSheet(
    useSafeArea: true,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    context: context,
    builder: (context) => Container(
      padding: EdgeInsets.symmetric(horizontal: 33.w),
      height: MediaQuery.of(context).size.height * 0.85,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 48.r,
                      backgroundImage:
                          const AssetImage('assets/images/profile_2.png'),
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Text(
                      '${profile.firstName} ${profile.lastName}',
                      style: gilroy18sp,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      profile.email,
                      style: chatTileMessage,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          parceDate(profile.dateOfBirth),
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
                          profile.phoneNumber,
                          style: subtitle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: cardSubtitle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Company Info',
                  style: tileHeader.copyWith(color: aboutGrey),
                ),
                SizedBox(
                  height: 15.h,
                ),
                CompanyInfoTile(
                  title: 'Name',
                  value: profile.companyName,
                ),
                SizedBox(
                  height: 13.h,
                ),
                CompanyInfoTile(
                  title: 'Website',
                  value: profile.companyWebsite,
                ),
                SizedBox(
                  height: 13.h,
                ),
                CompanyInfoTile(
                  title: 'Phone Number',
                  value: profile.companyPhoneNumber,
                ),
                SizedBox(
                  height: 13.h,
                ),
                CompanyInfoTile(
                  title: 'Address',
                  value: profile.companyAddress,
                ),
                SizedBox(
                  height: 13.h,
                ),
                CompanyInfoTile(
                  title: 'Fax Number',
                  value: profile.companyFaxNumber,
                ),
                SizedBox(
                  height: 13.h,
                ),
                CompanyInfoTile(
                  title: 'License Number',
                  value: profile.businessLicenseNumber,
                ),
                SizedBox(
                  height: 13.h,
                ),
                CompanyInfoTile(
                  title: 'WCB Number',
                  value: profile.wcbNumber,
                ),
                SizedBox(
                  height: 30.h,
                ),
                const Divider(),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'Documents',
                  style: tileHeader.copyWith(color: aboutGrey),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: profile.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ContractorProfileDocumentCard(
                      document: profile.documents[index],
                    );
                  },
                ),
                SizedBox(
                  height: 60.h,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24.h,
            child: Obx(() {
              return contractorJobController.isHiring.value
                  ? MaterialButton(
                      onPressed: () {},
                      minWidth: MediaQuery.of(context).size.width * 0.82,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      color: const Color(0xFFFF4E34),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: const CircularProgressIndicator(
                            color: Colors.white),
                      ),
                    )
                  : MaterialButton(
                      onPressed: () async {
                        bool success =
                            await contractorJobController.hireContractor(
                          jobId,
                          profile.id,
                        );
                        if (success) {
                          Navigator.pop(context);
                          showDoneSnackBar('Bid Accepted');
                        } else {
                          showErrorSnackBar('Some Problem Occured');
                        }
                      },
                      minWidth: MediaQuery.of(context).size.width * 0.82,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      color: const Color(0xFFFF4E34),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Text(
                          'Choose bid',
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
            }),
          ),
        ],
      ),
    ),
  );
}
