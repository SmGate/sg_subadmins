// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/utils/Constants/constants.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/Widgets/my_textform_field.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

import '../../../Routes/set_routes.dart';
import '../Controller/add_event_controller.dart';

class AddEventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: GetBuilder<AddEventScreenController>(
          init: AddEventScreenController(),
          builder: (controller) {
            return WillPopScope(
              onWillPop: () async {
                Get.offNamed(eventsscreen, arguments: controller.user);
                return true;
              },
              child: Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      MyBackButton(
                        text: 'Add Event',
                        onTap: () {
                          Get.offNamed(eventsscreen,
                              arguments: controller.user);
                        },
                      ),
                      32.ph,

                      // Add Image Section with Camera and Gallery Options
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: GestureDetector(
                          onTap: () {
                            _showImagePickerOptions(context, controller);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColors.appThem, width: 2),
                              color: Colors.white,
                              image: controller.imageFile != null
                                  ? DecorationImage(
                                      image: FileImage(
                                          File(controller.imageFile!.path)),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: controller.imageFile == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_a_photo,
                                          size: 50, color: AppColors.appThem),
                                      SizedBox(height: 10),
                                      Text(
                                        'Add Event Image',
                                        style: TextStyle(
                                          color: AppColors.appThem,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                            icon: Icon(Icons.edit,
                                                color: AppColors.appThem),
                                            onPressed: () {
                                              _showImagePickerOptions(
                                                  context, controller);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),

                      20.ph,
                      MyTextFormField(
                        controller: controller.eventTitleController,
                        validator: emptyStringValidator,
                        hintText: 'Enter Event Title',
                        labelText: 'Event Title',
                      ),
                      MyTextFormField(
                        controller: controller.eventDescriptionController,
                        validator: emptyStringValidator,
                        hintText: 'Enter Event Description',
                        labelText: 'Event Description',
                      ),
                      MyTextFormField(
                        onTap: () {
                          controller.StartDate(context);
                        },
                        controller: controller.eventStartDateController,
                        validator: emptyStringValidator,
                        hintText: 'Enter Event Start Date',
                        labelText: 'Start Date',
                      ),
                      MyTextFormField(
                        onTap: () {
                          controller.EndDate(context);
                        },
                        controller: controller.eventEndDateController,
                        validator: emptyStringValidator,
                        hintText: 'Enter Event End Date',
                        labelText: 'End Date',
                      ),
                      MyTextFormField(
                        controller: controller.startTimeController,
                        validator: emptyStringValidator,
                        labelText: 'Start Time ',
                        hintText: 'Start Time',
                        readOnly: true,
                        onTap: () {
                          controller.selectStartTime(context);
                        },
                      ),
                      MyTextFormField(
                        controller: controller.endTimeController,
                        validator: emptyStringValidator,
                        labelText: 'End Time ',
                        hintText: 'End Time',
                        readOnly: true,
                        onTap: () {
                          controller.selectEndTime(context);
                        },
                      ),
                      53.ph,
                      MyButton(
                        gradient: AppGradients.buttonGradient,
                        loading: controller.isLoading,
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            if (controller.isLoading == false) {
                              if (controller.imageFile != null) {
                                controller.addEvent(
                                  file: controller.imageFile!,
                                  startTime: controller.startTime!,
                                  endTime: controller.endTime!,
                                  userid: controller.userdata.userid!,
                                  token: controller.userdata.bearerToken!,
                                  eventTitle:
                                      controller.eventTitleController.text,
                                  eventDescription: controller
                                      .eventDescriptionController.text,
                                  eventStartDate:
                                      controller.eventStartDateController.text,
                                  eventEndDate:
                                      controller.eventEndDateController.text,
                                );
                              } else {
                                Get.snackbar("Error", "Please Add Image");
                              }
                            }
                          } else {
                            return null;
                          }
                        },
                        textColor: Colors.white,
                        color: primaryColor,
                        name: 'Save Event',
                        maxLines: 1,
                      ),

                      20.ph,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showImagePickerOptions(
      BuildContext context, AddEventScreenController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  controller.getFromGallery(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
                onTap: () {
                  controller.getFromCamera(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
