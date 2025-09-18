// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/SocietyRules/controller/society_rule_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/Widgets/my_textform_field.dart';
import 'package:societyadminapp/utils/Constants/constants.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

class AddSocietyRules extends StatefulWidget {
  const AddSocietyRules({super.key});

  @override
  State<AddSocietyRules> createState() => _AddSocietyRulesState();
}

class _AddSocietyRulesState extends State<AddSocietyRules> {
  @override
  Widget build(BuildContext context) {
    var societyRulesController = Get.find<SocietyRuleController>();
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(societyRule, arguments: societyRulesController.user);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.background,
          body: Form(
            key: societyRulesController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyBackButton(
                  text: "Add Rules",
                  onTap: () {
                    Get.offNamed(societyRule,
                        arguments: societyRulesController.user);
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                MyTextFormField(
                  onTap: () {},
                  width: double.infinity,
                  fillColor: Colors.white,
                  controller: societyRulesController.ruleTitleController,
                  validator: emptyStringValidator,
                  hintText: 'Enter Rule Title',
                  labelText: 'Enter Rule Title',
                ),
                MyTextFormField(
                  onTap: () {},
                  width: double.infinity,
                  fillColor: Colors.white,
                  controller: societyRulesController.ruleDescriptionController,
                  validator: emptyStringValidator,
                  hintText: 'Enter Rule Description',
                  labelText: 'Enter Rule Description',
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 40),
                    child: SizedBox(
                      width: 120,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          addRule(
                              title: societyRulesController
                                  .ruleTitleController.text,
                              desc: societyRulesController
                                  .ruleDescriptionController.text,
                              c: societyRulesController);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Border radius
                          ),
                        ),
                        child: Text(
                          societyRulesController.rulesList.length == 0
                              ? "Add"
                              : 'Add More',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  height: 200,
                  width: double.infinity,
                  color: AppColors.globalWhite,
                  child: societyRulesController.rulesList.length == 0 &&
                          societyRulesController.isRuleAdded.value == false
                      ? Center(child: Text("No Rules Added Yet"))
                      : ListView.builder(
                          itemCount: societyRulesController.rulesList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    societyRulesController
                                        .rulesList[index].title,
                                    style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 16.0,
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    societyRulesController
                                        .rulesList[index].description,
                                    style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 16.0,
                                      color: AppColors.dark,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Obx(() => MyButton(
                        loading: societyRulesController.loading.value,
                        gradient: AppGradients.buttonGradient,
                        name: "Save",
                        onPressed: () {
                          Payload payload = Payload(
                              societyId:
                                  societyRulesController.userdata.societyid!,
                              rules: societyRulesController.rulesList);

                          societyRulesController.addSocietyRule(data: payload);
                        },
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addRule({String? title, String? desc, SocietyRuleController, c}) {
    if (title!.isNotEmpty && desc!.isNotEmpty) {
      setState(() {
        c.isRuleAdded.value = true;
        c.rulesList.add(Rule(title: title, description: desc));
        c.ruleDescriptionController.clear();
        c.ruleTitleController.clear();
      });
    } else {
      Get.snackbar(
          "Message", "Please Enter Title And Description in Text Field");
    }
  }
}
