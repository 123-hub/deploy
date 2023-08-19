import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/labour_signup_screen_controller.dart';
import 'package:flutter_project_labour_app/models/experience_model.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/common/text_field_date_picker.dart';
import 'package:flutter_project_labour_app/screens/common/underline_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/validate_function.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Future<dynamic> addExperiencePopup(
    BuildContext context, LabourSignupScreenController controller) {
  var formKey = GlobalKey<FormState>();
  var positionTextController = TextEditingController();
  var companyNameTextController = TextEditingController();
  var descriptionTextController = TextEditingController();
  var startDateTextController = TextEditingController();
  var endDateTextController = TextEditingController();
  var startDate = DateTime.now();
  var endDate = DateTime.now();

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
                'Add Experience',
                style: authHeading,
              ),
              SizedBox(
                height: 32.h,
              ),
              UnderlineTextField(
                controller: positionTextController,
                hintText: 'Enter Your Position',
                validator: validate,
              ),
              SizedBox(
                height: 20.h,
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
                controller: descriptionTextController,
                hintText: 'Enter Experience Description',
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
              LongButton(
                text: 'Add Experience',
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      startDateTextController.text.isNotEmpty &&
                      endDateTextController.text.isNotEmpty) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    debugPrint('Valid');
                    var experience = ExperienceModel(
                      position: positionTextController.text,
                      companyName: companyNameTextController.text,
                      description: descriptionTextController.text,
                      from: startDate.toString(),
                      to: endDate.toString(),
                    );
                    var added = controller.addExperience(experience);
                    if (added) {
                      debugPrint(experience.toJson().toString());
                      Get.back();
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
