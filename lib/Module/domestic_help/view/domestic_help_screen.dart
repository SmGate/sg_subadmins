// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/domestic_help/controller/domestic_help_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/Widgets/my_textform_field.dart';
import 'package:societyadminapp/utils/Constants/constants.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

class DomeasticHelpScreen extends StatefulWidget {
  const DomeasticHelpScreen({super.key});

  @override
  State<DomeasticHelpScreen> createState() => _DomeasticHelpScreenState();
}

class _DomeasticHelpScreenState extends State<DomeasticHelpScreen> {
  var domesticHelpController = Get.put(DomesticHelpCOntroller());
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cnic = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController visitingfee = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  final List<String> _services = [
    'Plumber',
    'Electrician',
    'Cook',
    'Driver',
    'Maid',
    'Cleaner',
    'Gardener',
    'Security Guard',
  ];

  String? _selectedService;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(homescreen, arguments: domesticHelpController.userdata);
        return true;
      },
      child: SafeArea(
          child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              MyBackButton(
                onTap: () {
                  Get.offNamed(homescreen,
                      arguments: domesticHelpController.userdata);
                },
                text: "Domestic Help",
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dropdown
                      Text(
                        "Select Service",
                        style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 14.0,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.appThem),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.appThem),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.appThem,
                                width: 2), // active/focused border
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        value: _selectedService,
                        hint: const Text('Choose Service'),
                        items: _services
                            .map((service) => DropdownMenuItem(
                                  value: service,
                                  child: Text(service),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedService = value;
                          });
                        },
                      ),

                      const SizedBox(height: 10),
                      Text(
                        "Name",
                        style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 14.0,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        padding: EdgeInsets.all(0),
                        controller: name,
                        hintText: "Enter Name",
                        labelText: 'Enter Name',
                        validator: emptyStringValidator,
                        width: double.infinity,
                      ),

                      const SizedBox(height: 10),
                      Text(
                        "Email",
                        style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 14.0,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        padding: EdgeInsets.all(0),
                        controller: email,
                        hintText: "Enter Email",
                        labelText: 'Enter Email',
                        validator: emptyStringValidator,
                        width: double.infinity,
                      ),

                      const SizedBox(height: 10),
                      Text(
                        "Phone",
                        style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 14.0,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        padding: EdgeInsets.all(0),
                        controller: phone,
                        hintText: "Enter Phone",
                        labelText: 'Enter Phone',
                        validator: emptyStringValidator,
                        width: double.infinity,
                        textInputType: TextInputType.number,
                      ),

                      const SizedBox(height: 10),
                      Text(
                        "Visiting Fee",
                        style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 14.0,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 10),
                      MyTextFormField(
                        padding: EdgeInsets.all(0),
                        controller: visitingfee,
                        hintText: "Visiting Fee",
                        labelText: 'Visiting Fee',
                        width: double.infinity,
                        textInputType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Address",
                        style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 14.0,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        padding: EdgeInsets.all(0),
                        controller: address,
                        hintText: "Enter Address",
                        labelText: 'Enter Address',
                        validator: emptyStringValidator,
                        width: double.infinity,
                      ),

                      const SizedBox(height: 10),
                      Text(
                        "Cnic",
                        style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 14.0,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        padding: EdgeInsets.all(0),
                        width: double.infinity,
                        textInputType: TextInputType.number,
                        controller: cnic,
                        validator: emptyStringValidator,
                        hintText: 'Enter Cnic',
                        labelText: 'Cnic',
                        maxLength: 15,
                        onChanged: (value) {
                          String formattedText = formatText(value);

                          cnic.value = TextEditingValue(
                            text: formattedText,
                            selection: TextSelection.collapsed(
                                offset: formattedText.length),
                          );
                        },
                      ),

                      Text(
                        "Age",
                        style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 14.0,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        padding: EdgeInsets.all(0),
                        textInputType: TextInputType.number,
                        controller: age,
                        hintText: "Enter Age",
                        labelText: 'Enter Age',
                        validator: emptyStringValidator,
                        width: double.infinity,
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Center(
                        child: Obx(() => MyButton(
                              gradient: AppGradients.buttonGradient,
                              // loading: controller.loading,
                              height: 43.h,
                              loading: domesticHelpController
                                  .registerDomesticHelperLoading.value,
                              width: double.infinity,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  domesticHelpController.registerDomesticHelper(
                                      societyId: domesticHelpController
                                          .userdata.societyid
                                          .toString(),
                                      name: name.text,
                                      phone: phone.text,
                                      cnic: cnic.text,
                                      age: age.text,
                                      address: address.text,
                                      occupation: _selectedService,
                                      visitingFee: visitingfee.text,
                                      subadminId: domesticHelpController
                                          .userdata.userid
                                          .toString());
                                }
                              },
                              name: 'DONE',
                              border: 6,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  /////  formate cnic text

  String formatText(String text) {
    text = text.replaceAll(RegExp(r'\D'), '');

    if (text.length > 15) {
      text = text.substring(0, 15);
    }

    String formattedText = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 5 || i == 12) {
        formattedText += '-';
      }
      formattedText += text[i];
    }

    return formattedText;
  }
}
