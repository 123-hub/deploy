import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/labour_profile_controller.dart';
import 'package:flutter_project_labour_app/models/labour_document.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/common/underline_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/validate_function.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<dynamic> addProfileDocumentPopup(
    BuildContext context, LabourProfileController controller) {
  var formKey = GlobalKey<FormState>();
  var documentNameTextController = TextEditingController();
  var documentURLTextController = TextEditingController();
  var descriptionTextController = TextEditingController();

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
                'Add Document',
                style: authHeading,
              ),
              SizedBox(
                height: 32.h,
              ),
              UnderlineTextField(
                controller: documentNameTextController,
                hintText: 'Enter Document Name',
                validator: validate,
              ),
              SizedBox(
                height: 20.h,
              ),
              UnderlineTextField(
                controller: documentURLTextController,
                hintText: 'Enter Document URL',
                validator: validate,
              ),
              SizedBox(
                height: 20.h,
              ),
              UnderlineTextField(
                controller: descriptionTextController,
                hintText: 'Enter Document Description',
                validator: validate,
              ),
              SizedBox(
                height: 20.h,
              ),
              LongButton(
                text: 'Add Document',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    debugPrint('Valid');
                    var document = Document(
                      documentName: documentNameTextController.text,
                      documentUrl: documentURLTextController.text,
                      description: descriptionTextController.text,
                      createdAt: null,
                      id: null,
                      updatedAt: null,
                      labourId: null,
                    );
                    debugPrint(document.toJson().toString());
                    var added = controller.addDocument(document);
                    if (added) {
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