import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/contractor_signup_screen_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_appbar.dart';
import 'package:flutter_project_labour_app/screens/common/auth_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/next_button.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/contractor_signup/contractor_documents_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContractorAdditionalInfoScreen extends StatelessWidget {
  ContractorAdditionalInfoScreen({super.key});
  final contractorSignUpScreenController =
      Get.find<ContractorSignUpScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 37.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      const AuthAppBar(),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        'Additional Info',
                        style: authHeading,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(
                        'Just a bit more information before you are ready to go',
                        style: subtitle.copyWith(color: subtitleGrey),
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      Obx(() {
                        return AuthTextField(
                          emailTextController: contractorSignUpScreenController
                              .companyNameTextController,
                          hintText: 'Enter Company Name',
                          isPasswordField: false,
                          primaryIcon: Icons.business,
                          textInputType: TextInputType.name,
                          errorText: contractorSignUpScreenController
                                  .isCompanyNamevalid.value
                              ? null
                              : contractorSignUpScreenController
                                  .companyNameErrorMessage,
                        );
                      }),
                      SizedBox(
                        height: 24.h,
                      ),
                      Obx(() {
                        return AuthTextField(
                          emailTextController: contractorSignUpScreenController
                              .companyAddressTextController,
                          hintText: 'Enter Company Address',
                          isPasswordField: false,
                          primaryIcon: Icons.location_on_outlined,
                          textInputType: TextInputType.name,
                          errorText: contractorSignUpScreenController
                                  .isCompanyAddressvalid.value
                              ? null
                              : contractorSignUpScreenController
                                  .companyAddressErrorMessage,
                        );
                      }),
                      SizedBox(
                        height: 24.h,
                      ),
                      Obx(() {
                        return AuthTextField(
                          emailTextController: contractorSignUpScreenController
                              .companyPhoneNumberTextController,
                          hintText: 'Enter Company Phone Number',
                          isPasswordField: false,
                          primaryIcon: Icons.phone,
                          textInputType: TextInputType.phone,
                          errorText: contractorSignUpScreenController
                                  .isCompanyphoneNumbervalid.value
                              ? null
                              : contractorSignUpScreenController
                                  .companyPhoneNumberErrorMessage,
                        );
                      }),
                      SizedBox(
                        height: 24.h,
                      ),
                      Obx(() {
                        return AuthTextField(
                          emailTextController: contractorSignUpScreenController
                              .companyWebsiteTextController,
                          hintText: 'Enter Company Website',
                          isPasswordField: false,
                          primaryIcon: Icons.language,
                          textInputType: TextInputType.url,
                          errorText: contractorSignUpScreenController
                                  .isCompanyWebsitevalid.value
                              ? null
                              : contractorSignUpScreenController
                                  .companyWebsiteErrorMessage,
                        );
                      }),
                      SizedBox(
                        height: 24.h,
                      ),
                      Obx(() {
                        return AuthTextField(
                          emailTextController: contractorSignUpScreenController
                              .companyFaxNumberTextController,
                          hintText: 'Enter Company Fax Number',
                          isPasswordField: false,
                          primaryIcon: Icons.fax,
                          textInputType: TextInputType.number,
                          errorText: contractorSignUpScreenController
                                  .isCompanyFaxNumbervalid.value
                              ? null
                              : contractorSignUpScreenController
                                  .companyFaxNumberErrorMessage,
                        );
                      }),
                      SizedBox(
                        height: 24.h,
                      ),
                      Obx(() {
                        return AuthTextField(
                          emailTextController: contractorSignUpScreenController
                              .businesslicenseNumberTextController,
                          hintText: 'Enter Business License Number',
                          isPasswordField: false,
                          primaryIcon: Icons.gavel,
                          textInputType: TextInputType.name,
                          errorText: contractorSignUpScreenController
                                  .isbusinesslicenseNumbervalid.value
                              ? null
                              : contractorSignUpScreenController
                                  .businesslicenseNumberErrorMessage,
                        );
                      }),
                      SizedBox(
                        height: 24.h,
                      ),
                      Obx(() {
                        return AuthTextField(
                          emailTextController: contractorSignUpScreenController
                              .wcbNumberTextController,
                          hintText: 'Enter WCB number',
                          isPasswordField: false,
                          primaryIcon: Icons.pin,
                          textInputType: TextInputType.name,
                          errorText: contractorSignUpScreenController
                                  .iswcbNumbervalid.value
                              ? null
                              : contractorSignUpScreenController
                                  .wcbNumberErrorMessage,
                        );
                      }),
                      SizedBox(height: 100.h,),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 30.h,
                right: 30.w,
                child: NextButton(
                  text: 'Next',
                  isArrowPresent: true,
                  onPressed: () {
                    if (contractorSignUpScreenController.isSecondPageValid()) {
                      Get.to(() => ContractorDocumentScreen());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
