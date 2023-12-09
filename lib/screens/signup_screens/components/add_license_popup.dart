import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/labour_signup_screen_controller.dart';
import 'package:flutter_project_labour_app/models/license_model.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/common/text_field_date_picker.dart';
import 'package:flutter_project_labour_app/screens/common/underline_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/validate_function.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Future<dynamic> addLicensePopUp(
    BuildContext context, LabourSignupScreenController controller) {
  var formKey = GlobalKey<FormState>();
  var licenseNameTextController = TextEditingController();
  var expiryDateTextController = TextEditingController();
  var descriptionTextController = TextEditingController();
  var startDateTextController = TextEditingController();
  var endDateTextController = TextEditingController();
  var startDate = DateTime.now();
  var endDate = DateTime.now();
  var expiryDate = DateTime.now();

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
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add License',
                style: authHeading,
              ),
              SizedBox(
                height: 32.h,
              ),
              UnderlineTextField(
                controller: licenseNameTextController,
                hintText: 'Enter Your License Name',
                validator: validate,
              ),
              SizedBox(
                height: 20.h,
              ),
              UnderlineTextField(
                controller: descriptionTextController,
                hintText: 'Enter License Description',
                validator: validate,
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFieldDatePicker(
                onTap: (DateTime date) {
                  startDate = date;
                  String formatedDate = DateFormat('dd/MM/yyyy').format(date);
                  startDateTextController.text = formatedDate;
                },
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
                controller: startDateTextController,
                hintText: "Date You started Working",
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFieldDatePicker(
                onTap: (DateTime date) {
                  endDate = date;
                  String formatedDate = DateFormat('dd/MM/yyyy').format(date);
                  endDateTextController.text = formatedDate;
                },
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
                controller: endDateTextController,
                hintText: "Date You ended Working",
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFieldDatePicker(
                onTap: (DateTime date) {
                  expiryDate = date;
                  String formatedDate = DateFormat('dd/MM/yyyy').format(date);
                  expiryDateTextController.text = formatedDate;
                },
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2050),
                controller: expiryDateTextController,
                hintText: "Date You License Expire",
              ),
              SizedBox(
                height: 20.h,
              ),
              LongButton(
                text: 'Add License',
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      startDateTextController.text.isNotEmpty &&
                      endDateTextController.text.isNotEmpty &&
                      expiryDateTextController.text.isNotEmpty) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    debugPrint('Valid');
                    if (startDate.isBefore(endDate)) {
                      if (endDate.isBefore(expiryDate)) {
                        var license = LicenseModel(
                          licenseName: licenseNameTextController.text,
                          description: descriptionTextController.text,
                          from: startDate.toString(),
                          to: endDate.toString(),
                          expiryDate: expiryDate.toString(),
                        );
                        var added = controller.addLicense(license);
                        if (added) {
                          debugPrint(license.toJson().toString());
                          Get.back();
                        }
                      } else {
                        showErrorSnackBar(
                          "End date must be before expire date",
                        );
                      }
                    } else {
                      showErrorSnackBar("Start date must be before end date");
                    }
                  }
                },
              ),
              SizedBox(
                height: 32.h,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
