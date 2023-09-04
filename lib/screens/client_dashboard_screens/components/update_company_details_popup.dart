import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_profile_controller.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/common/underline_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/validate_function.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<dynamic> updateCompanyDetailsPopUp(
    BuildContext context, ContractorProfileController controller) {
  var companyNameTextController = TextEditingController();
  companyNameTextController.text =
      controller.contractorProfile.value!.companyName;
  var companyWebsiteTextController = TextEditingController();
  companyWebsiteTextController.text =
      controller.contractorProfile.value!.companyWebsite;
  var companyPhoneNumberTextController = TextEditingController();
  companyPhoneNumberTextController.text =
      controller.contractorProfile.value!.companyPhoneNumber;
  var companyAddressTextController = TextEditingController();
  companyAddressTextController.text =
      controller.contractorProfile.value!.companyAddress;
  var companyFaxNumberTextController = TextEditingController();
  companyFaxNumberTextController.text =
      controller.contractorProfile.value!.companyFaxNumber;
  var licenseNumberTextController = TextEditingController();
  licenseNumberTextController.text =
      controller.contractorProfile.value!.businessLicenseNumber;
  var wcbNumberTextController = TextEditingController();
  wcbNumberTextController.text = controller.contractorProfile.value!.wcbNumber;

  return showModalBottomSheet(
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    context: context,
    builder: (context) => SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 32.w,
          right: 32.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Profile',
              style: authHeading,
            ),
            SizedBox(
              height: 32.h,
            ),
            UnderlineTextField(
              controller: companyNameTextController,
              hintText: 'Enter Company Name',
              validator: validate,
            ),
            SizedBox(
              height: 20.h,
            ),
            UnderlineTextField(
              controller: companyWebsiteTextController,
              hintText: 'Enter Company Website',
              validator: validate,
              textInputType: TextInputType.url,
            ),
            SizedBox(
              height: 20.h,
            ),
            UnderlineTextField(
              controller: companyPhoneNumberTextController,
              hintText: 'Enter Company Phone Number',
              validator: validate,
              textInputType: TextInputType.phone,
            ),
            SizedBox(
              height: 20.h,
            ),
            UnderlineTextField(
              controller: companyAddressTextController,
              hintText: 'Enter Company Address',
              validator: validate,
              textInputType: TextInputType.streetAddress,
            ),
            SizedBox(
              height: 20.h,
            ),
            UnderlineTextField(
              controller: companyFaxNumberTextController,
              hintText: 'Enter Fax Number',
              validator: validate,
              textInputType: TextInputType.number,
            ),
            SizedBox(
              height: 20.h,
            ),
            UnderlineTextField(
              controller: licenseNumberTextController,
              hintText: 'Enter License Number',
              validator: validate,
            ),
            SizedBox(
              height: 20.h,
            ),
            UnderlineTextField(
              controller: wcbNumberTextController,
              hintText: 'Enter WCB Number',
              validator: validate,
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(() {
              return controller.isUpdating.value
                  ? const InactiveLongButton()
                  : LongButton(
                      text: 'Update Profile',
                      onPressed: () async {
                        controller.changeIsUpdating(true);
                        controller.contractorProfile.value!.companyName =
                            companyNameTextController.text;
                        controller.contractorProfile.value!.companyWebsite =
                            companyWebsiteTextController.text;
                        controller.contractorProfile.value!.companyPhoneNumber =
                            companyPhoneNumberTextController.text;
                        controller.contractorProfile.value!.companyAddress =
                            companyAddressTextController.text;
                        controller.contractorProfile.value!.companyFaxNumber =
                            companyFaxNumberTextController.text;
                        controller.contractorProfile.value!.businessLicenseNumber =
                            licenseNumberTextController.text;
                        controller.contractorProfile.value!.wcbNumber =
                            wcbNumberTextController.text;
                        bool result = await controller.updateProfile();
                        controller.changeIsUpdating(false);
                        if (result) {
                          Get.back();
                        } else {
                          showErrorSnackBar(
                              'Some problem occured while updating');
                        }
                      },
                    );
            }),
            SizedBox(
              height: 32.h,
            ),
          ],
        ),
      ),
    ),
  );
}
