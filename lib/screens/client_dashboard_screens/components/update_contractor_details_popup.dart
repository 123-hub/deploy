import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_profile_controller.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/common/text_field_date_picker.dart';
import 'package:flutter_project_labour_app/screens/common/underline_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/validate_function.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/parce_date.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Future<dynamic> updateContractorDetailsPopUp(
    BuildContext context, ContractorProfileController controller) {
  var firstNameTextController = TextEditingController();
  firstNameTextController.text = controller.contractorProfile.value!.firstName;
  var lastNameTextController = TextEditingController();
  lastNameTextController.text = controller.contractorProfile.value!.lastName;
  var phoneNumberTextController = TextEditingController();
  phoneNumberTextController.text =
      controller.contractorProfile.value!.phoneNumber;
  var dateOfBirthTextController = TextEditingController();
  dateOfBirthTextController.text =
      parceDate(controller.contractorProfile.value!.dateOfBirth);
  var dateOfBirth =
      DateTime.parse(controller.contractorProfile.value!.dateOfBirth);

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
              controller: firstNameTextController,
              hintText: 'Enter First Name',
              validator: validate,
            ),
            SizedBox(
              height: 20.h,
            ),
            UnderlineTextField(
              controller: lastNameTextController,
              hintText: 'Enter Last Name',
              validator: validate,
            ),
            SizedBox(
              height: 20.h,
            ),
            UnderlineTextField(
              controller: phoneNumberTextController,
              hintText: 'Enter Phone Number',
              validator: validate,
              textInputType: TextInputType.phone,
            ),
            SizedBox(
              height: 20.h,
            ),
            TextFieldDatePicker(
              onTap: (DateTime date) {
                dateOfBirth = date;
                String formatedDate = DateFormat('dd/MM/yyyy').format(date);
                dateOfBirthTextController.text = formatedDate;
              },
              initialDate: dateOfBirth,
              firstDate: DateTime(1950),
              lastDate: DateTime(2005),
              controller: dateOfBirthTextController,
              hintText: "Enter Date of Birth",
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
                        controller.contractorProfile.value!.firstName =
                            firstNameTextController.text;
                        controller.contractorProfile.value!.lastName =
                            lastNameTextController.text;
                        controller.contractorProfile.value!.phoneNumber =
                            phoneNumberTextController.text;
                        controller.contractorProfile.value!.dateOfBirth =
                            '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateOfBirth)}Z';

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
