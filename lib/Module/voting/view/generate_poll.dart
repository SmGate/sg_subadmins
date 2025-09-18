import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/voting/controller/voting_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/Widgets/my_textform_field.dart';
import 'package:societyadminapp/utils/Constants/constants.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

class GeneratePoll extends StatefulWidget {
  const GeneratePoll({super.key});

  @override
  State<GeneratePoll> createState() => _GeneratePollState();
}

class _GeneratePollState extends State<GeneratePoll> {
  @override
  Widget build(BuildContext context) {
    var votingController = Get.find<VotingController>();
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(voting, arguments: votingController.user);

        votingController.options.clear();

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.background,
          body: Form(
            key: votingController.formKey,
            child: Column(
              children: [
                MyBackButton(
                  text: "Create Poll",
                  onTap: () {
                    Get.offNamed(voting, arguments: votingController.user);

                    votingController.options.clear();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MyTextFormField(
                  fillColor: Colors.white,
                  controller: votingController.titleController,
                  validator: emptyStringValidator,
                  hintText: 'TITLE',
                  labelText: 'TITLE',
                ),
                MyTextFormField(
                  onTap: () {
                    votingController.NoticeEndDate(context);
                  },
                  fillColor: Colors.white,
                  controller: votingController.endnoticedateController,
                  validator: emptyStringValidator,
                  hintText: 'Choose End Date',
                  labelText: 'Choose end Date',
                ),
                MyTextFormField(
                  onTap: () {
                    votingController.NoticeEndTime(context);
                  },
                  fillColor: Colors.white,
                  controller: votingController.endnoticetimeController,
                  validator: emptyStringValidator,
                  hintText: 'Choose END TIME',
                  labelText: 'Choose END TIME',
                ),
                MyTextFormField(
                  fillColor: Colors.white,
                  controller: votingController.optionController,
                  // validator: emptyStringValidator,
                  hintText: 'Enter Option',
                  labelText: 'Enter Option',
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
                          // if (votingController.formKey.currentState!
                          //     .validate()) {
                          addOption(votingController);
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Border radius
                          ),
                        ),
                        child: Text(
                          votingController.options.length == 0
                              ? "Add Option"
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
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          checkColor: AppColors.globalWhite,
                          activeColor: AppColors.appThem,
                          value: votingController.isResonable.value == 1,
                          onChanged: (bool? value) {
                            votingController.updateCheckbox(value ?? false);
                          },
                        ),
                        Spacer(),
                        Text(
                          'Allow reason',
                          style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 14.0,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: votingController.options.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.only(left: 40),
                        title: Text(
                            'Option ${index + 1}: ${votingController.options[index]}'),
                      );
                    },
                  ),
                ),
                Obx(() => MyButton(
                      gradient: AppGradients.buttonGradient,
                      loading: votingController.loading.value,
                      name: "Save",
                      onPressed: () {
                        if (votingController.formKey.currentState!.validate()) {
                          votingController.generatePoll(
                              societyId:
                                  votingController.user.societyid.toString(),
                              title: votingController.titleController.text,
                              endDate:
                                  votingController.endnoticedateController.text,
                              endTime:
                                  votingController.endnoticetimeController.text,
                              isResonable: votingController.isResonable.value,
                              options: votingController.options,
                              subadminId:
                                  votingController.userdata?.userid.toString());
                        }
                      },
                    )),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addOption(VotingController controller) {
    if (controller.optionController.text.isNotEmpty) {
      setState(() {
        controller.options.add(controller.optionController.text);
        controller.optionController.clear();
      });
    } else {
      Get.snackbar("Message", "Please Enter Option in Text Field");
    }
  }
}
