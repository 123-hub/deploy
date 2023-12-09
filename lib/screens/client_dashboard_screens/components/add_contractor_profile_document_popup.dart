import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_profile_controller.dart';
import 'package:flutter_project_labour_app/models/contractor_document.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/common/underline_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/validate_function.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<dynamic> addContractorProfileDocument(
    BuildContext context, ContractorProfileController controller,
    {ContractorDocument? document}) {
  var formKey = GlobalKey<FormState>();
  var ownerDrivingLicenseTextController = TextEditingController();
  var insuranceLiabilityTextController = TextEditingController();
  var wcbDocumentTextController = TextEditingController();
  var businessLicenseTextController = TextEditingController();
  var documentUrlTextController = TextEditingController();
  if (document != null) {
    ownerDrivingLicenseTextController.text = document.ownerDrivingLicense;
    insuranceLiabilityTextController.text = document.insuranceLiability;
    wcbDocumentTextController.text = document.wcbDocument;
    businessLicenseTextController.text = document.businessLicense;
    documentUrlTextController.text = document.documentUrl;
  }

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
                document != null ? 'Update Document' : 'Add Document',
                style: authHeading,
              ),
              SizedBox(
                height: 32.h,
              ),
              UnderlineTextField(
                controller: ownerDrivingLicenseTextController,
                hintText: 'Enter Owner Driving license',
                validator: validate,
              ),
              SizedBox(
                height: 20.h,
              ),
              UnderlineTextField(
                controller: insuranceLiabilityTextController,
                hintText: 'Enter insurance liability',
                validator: validate,
              ),
              SizedBox(
                height: 20.h,
              ),
              UnderlineTextField(
                controller: wcbDocumentTextController,
                hintText: 'Enter WCB document',
                validator: validate,
              ),
              SizedBox(
                height: 20.h,
              ),
              UnderlineTextField(
                controller: businessLicenseTextController,
                hintText: 'Enter Business License',
                validator: validate,
              ),
              SizedBox(
                height: 20.h,
              ),
              UnderlineTextField(
                controller: documentUrlTextController,
                hintText: 'Enter Document URL',
                validator: validate,
              ),
              SizedBox(
                height: 20.h,
              ),
              LongButton(
                text: document != null ? 'Update Document' : 'Add Document',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    debugPrint('Valid');
                    if (document != null) {
                      controller.deleteDocument(document);
                      document.businessLicense =
                          businessLicenseTextController.text;
                      document.insuranceLiability =
                          insuranceLiabilityTextController.text;
                      document.ownerDrivingLicense =
                          ownerDrivingLicenseTextController.text;
                      document.wcbDocument = wcbDocumentTextController.text;
                      document.documentUrl = documentUrlTextController.text;
                      controller.addDocument(document);
                      Get.back();
                    } else {
                      var document = ContractorDocument(
                        ownerDrivingLicense:
                            ownerDrivingLicenseTextController.text,
                        insuranceLiability:
                            insuranceLiabilityTextController.text,
                        wcbDocument: wcbDocumentTextController.text,
                        businessLicense: businessLicenseTextController.text,
                        documentUrl: documentUrlTextController.text,
                        id: 0,
                        contractorId: controller.contractorProfile.value!.id,
                        createdAt: null,
                        updatedAt: null,
                      );
                      debugPrint(document.toJson().toString());
                      var added = controller.addDocument(document);
                      if (added) {
                        Get.back();
                      }
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
