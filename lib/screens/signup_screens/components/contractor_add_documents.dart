import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_signup_screen_controller.dart';
import 'package:flutter_project_labour_app/controllers/file_upload_controller.dart';
import 'package:flutter_project_labour_app/models/contractor_document_model.dart';
import 'package:flutter_project_labour_app/screens/common/long_button.dart';
import 'package:flutter_project_labour_app/screens/common/underline_text_field_clickable.dart';
import 'package:flutter_project_labour_app/screens/common/validate_function.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_project_labour_app/util/pick_a_file.dart';
import 'package:flutter_project_labour_app/util/snackbars.dart';
import 'package:flutter_project_labour_app/util/upload_file.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<dynamic> contractorAddDocumentPopup(
    BuildContext context, ContractorSignUpScreenController controller) {
  var formKey = GlobalKey<FormState>();
  var ownerDrivingLicenseTextController = TextEditingController();
  var insuranceLiabilityTextController = TextEditingController();
  var wcbDocumentTextController = TextEditingController();
  var businessLicenseTextController = TextEditingController();
  var documentUrlTextController = TextEditingController();

  var documentList = List.filled(5, File(''));
  var fileUploadCOntroller = Get.put(FileUploadController());
  var links = List<String>.filled(5, '');

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
              UnderlineTextFieldClickable(
                controller: ownerDrivingLicenseTextController,
                hintText: 'Select Owner Driving license',
                validator: validate,
                onClick: () async {
                  var value = await pickAFile();
                  if (value != null) {
                    ownerDrivingLicenseTextController.text = value['name'];
                    documentList[0] = value['file'];
                  }
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              UnderlineTextFieldClickable(
                controller: insuranceLiabilityTextController,
                hintText: 'Select insurance liability',
                validator: validate,
                onClick: () async {
                  var value = await pickAFile();
                  if (value != null) {
                    insuranceLiabilityTextController.text = value['name'];
                    documentList[1] = value['file'];
                  }
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              UnderlineTextFieldClickable(
                controller: wcbDocumentTextController,
                hintText: 'Select WCB document',
                validator: validate,
                onClick: () async {
                  var value = await pickAFile();
                  if (value != null) {
                    wcbDocumentTextController.text = value['name'];
                    documentList[2] = value['file'];
                  }
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              UnderlineTextFieldClickable(
                controller: businessLicenseTextController,
                hintText: 'Select Business License',
                validator: validate,
                onClick: () async {
                  var value = await pickAFile();
                  if (value != null) {
                    businessLicenseTextController.text = value['name'];
                    documentList[3] = value['file'];
                  }
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              UnderlineTextFieldClickable(
                controller: documentUrlTextController,
                hintText: 'Select Document URL',
                validator: validate,
                onClick: () async {
                  var value = await pickAFile();
                  if (value != null) {
                    documentUrlTextController.text = value['name'];
                    documentList[4] = value['file'];
                  }
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Obx(() {
                return fileUploadCOntroller.isUploading.value
                    ? const InactiveLongButton()
                    : LongButton(
                        text: 'Add Document',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            debugPrint('Valid');
                            fileUploadCOntroller.changeIsUploading(true);
                            print(documentList);
                            for (int i = 0; i < documentList.length; i++) {
                              var url = await uploadFile(
                                  userType: 'contractor',
                                  file: documentList[i]);
                              if (url == null) {
                                showErrorSnackBar(
                                  '${documentList[i].path.split('/').last} was not uploaded',
                                );
                                break;
                              }
                              links[i] = url;
                            }
                            fileUploadCOntroller.changeIsUploading(false);
                            var empty =
                                links.where((element) => element == '').length;
                            if (empty <= 0) {
                              var document = ContractorDocumentModel(
                                ownerDrivingLicense: links[0],
                                insuranceLiability: links[1],
                                wcbDocument: links[2],
                                businessLicense: links[3],
                                documentUrl: links[4],
                              );
                              debugPrint(document.toJson().toString());
                              var added = controller.addDocument(document);
                              if (added) {
                                Get.back();
                              }
                            } else {
                              showErrorSnackBar("Not all files got uploaded");
                            }
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
    ),
  );
}
