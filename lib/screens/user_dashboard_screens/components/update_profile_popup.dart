import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/labour_profile_controller.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/common/text_field_date_picker.dart';
import 'package:flutter_project_labour_app/screens/common/underline_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/validate_function.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/parce_date.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Future<dynamic> updateProfilePopUp(
    BuildContext context, LabourProfileController controller) {
  var firstNameTextController = TextEditingController();
  firstNameTextController.text = controller.labourProfile.value!.firstName;
  var lastNameTextController = TextEditingController();
  lastNameTextController.text = controller.labourProfile.value!.lastName;
  var phoneNumberTextController = TextEditingController();
  phoneNumberTextController.text = controller.labourProfile.value!.phoneNumber;
  var dateOfBirthTextController = TextEditingController();
  dateOfBirthTextController.text =
      parceDate(controller.labourProfile.value!.dob);
  var expectedHourRateTextController = TextEditingController();
  expectedHourRateTextController.text =
      controller.labourProfile.value!.expectedHourRate.toString();
  var dateOfBirth = DateTime.parse(controller.labourProfile.value!.dob);
  final List<String> days = ['Su', 'M', 'Tu', 'W', 'Th', 'F', 'Sa'];

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
            UnderlineTextField(
              controller: expectedHourRateTextController,
              hintText: 'Enter Expected Hour Rate',
              validator: validate,
              textInputType: TextInputType.number,
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
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
              controller: dateOfBirthTextController,
              hintText: "Enter Date of Birth",
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: double.infinity,
              height: 60.h,
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < controller.days.length; i++)
                      InkWell(
                        onTap: () {
                          controller.selectDays(i);
                        },
                        child: Container(
                          height: 40.w,
                          width: 40.w,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: controller.days[i]
                                ? primaryRed
                                : searchBarColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Text(
                              days[i],
                              style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: controller.days[i]
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                );
              }),
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
                        controller.labourProfile.value!.firstName =
                            firstNameTextController.text;
                        controller.labourProfile.value!.lastName =
                            lastNameTextController.text;
                        controller.labourProfile.value!.phoneNumber =
                            phoneNumberTextController.text;
                        controller.labourProfile.value!.expectedHourRate =
                            int.parse(expectedHourRateTextController.text);
                        controller.labourProfile.value!.dob =
                            '${DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateOfBirth)}Z';
                        controller.labourProfile.value!.availabilityDates =
                            controller.getDays();
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
