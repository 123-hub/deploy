import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/controllers/signup_screen_controller.dart';
import 'package:flutter_project_labour_app/screens/common/auth_appbar.dart';
import 'package:flutter_project_labour_app/screens/common/auth_text_field.dart';
import 'package:flutter_project_labour_app/screens/common/next_button.dart';
import 'package:flutter_project_labour_app/screens/common/skill_capsul.dart';
import 'package:flutter_project_labour_app/screens/common/text_field_date_picker.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/add_document.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/add_documents_popup.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/add_skill_text_field.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/components/document_card.dart';
import 'package:flutter_project_labour_app/screens/signup_screens/labour_signup/labour_experience_screen.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_project_labour_app/util/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:weekday_selector/weekday_selector.dart';

class AdditionalInfoScreen extends StatelessWidget {
  AdditionalInfoScreen({super.key});
  final skillTextController = TextEditingController();
  final signupScreenController = Get.find<LabourSignupScreenController>();

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
                        'Lorem ipsum dolor sit amet, consectetur adipiscing',
                        style: subtitle.copyWith(color: subtitleGrey),
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      Obx(() {
                        return AuthTextField(
                          emailTextController:
                              signupScreenController.expectedRateTextController,
                          hintText: 'Expected Hourly Rate',
                          isPasswordField: false,
                          primaryIcon: Icons.currency_rupee,
                          textInputType: TextInputType.number,
                          errorText: signupScreenController
                                  .isHourlyRateValid.value
                              ? null
                              : signupScreenController.hourlyRateErrorMessage,
                        );
                      }),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        'Available days',
                        style: authInfoHeading,
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Obx(() {
                        return WeekdaySelector(
                          selectedColor: Colors.white,
                          selectedFillColor: primeryRed,
                          onChanged: signupScreenController.selectDays,
                          values: signupScreenController.days,
                        );
                      }),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Knows Driving',
                            style: authInfoHeading,
                          ),
                          ToggleSwitch(
                            initialLabelIndex: 1,
                            totalSwitches: 2,
                            activeFgColor: Colors.white,
                            activeBgColor: const [primeryRed, primeryRed],
                            inactiveBgColor: searchBarColor,
                            cornerRadius: 20,
                            labels: const [
                              'Yes',
                              'No',
                            ],
                            onToggle: signupScreenController.changeCanDrive,
                          ),
                        ],
                      ),
                      Obx(
                        () => signupScreenController.canDrive.value
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  TextFieldDatePicker(
                                    hintText: 'License Expiry Date',
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2050),
                                    onTap: (DateTime date) {
                                      String formatedDate =
                                          DateFormat('dd/MM/yyyy').format(date);
                                      signupScreenController
                                          .lisenceExpiryTextController
                                          .text = formatedDate;
                                      signupScreenController.licencExpiry =
                                          date;
                                    },
                                    errorMessage: signupScreenController
                                            .isexpiryDateValid.value
                                        ? null
                                        : signupScreenController
                                            .expiryDateErrorMessage,
                                    controller: signupScreenController
                                        .lisenceExpiryTextController,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Text(
                        'Add Skills',
                        style: authInfoHeading,
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Obx(() {
                        return Wrap(
                          direction: Axis.horizontal,
                          spacing: 10,
                          children: signupScreenController.tradeTypes
                              .map(
                                (String element) => SkillCapsule(
                                  name: element,
                                  onDelete: () {
                                    signupScreenController
                                        .deleteTradeType(element);
                                  },
                                ),
                              )
                              .toList(),
                        );
                      }),
                      AddSkillTextField(
                        skillTextController: skillTextController,
                        onTap: () {
                          var isSuccessful = signupScreenController
                              .addTradeType(skillTextController.text);
                          if (isSuccessful) {
                            skillTextController.clear();
                          }
                        },
                        onSubmit: (String? value) {
                          if (value != null && value.isNotEmpty) {
                            var isSuccessful = signupScreenController
                                .addTradeType(skillTextController.text);
                            if (isSuccessful) {
                              skillTextController.clear();
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      AddDocument(
                        title: 'Add Documents',
                        onTap: () {
                          addDocumentPopup(context, signupScreenController);
                        },
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Obx(() {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: signupScreenController.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            var doc = signupScreenController.documents[index];
                            return DocumentCard(
                              documentModel: doc,
                              onDelete: () {
                                signupScreenController.deleteDocument(doc);
                              },
                            );
                          },
                        );
                      }),
                      SizedBox(
                        height: 100.h,
                      ),
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
                    if (signupScreenController.isSecondPageValid()) {
                      Get.to(() => LabourExperienceScreen());
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
