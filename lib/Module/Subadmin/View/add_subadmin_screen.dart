import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/Widgets/my_textform_field.dart';
import 'package:societyadminapp/Widgets/my_password_textform_field.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/utils/Constants/constants.dart';
import 'package:societyadminapp/Module/Subadmin/Controller/subadmin_list_controller.dart';

class AddSubadminScreen extends StatefulWidget {
  const AddSubadminScreen({Key? key}) : super(key: key);

  @override
  State<AddSubadminScreen> createState() => _AddSubadminScreenState();
}

class _AddSubadminScreenState extends State<AddSubadminScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _address = TextEditingController();
  final _mobile = TextEditingController();
  final _cnic = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _address.dispose();
    _mobile.dispose();
    _cnic.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubadminListController>(builder: (c) {
      return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.background,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyBackButton(
                      text: 'Add Subadmin',
                      onTap: () => Get.back(),
                    ),
                    25.0.ph,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          MyTextFormField(
                            padding: EdgeInsets.only(top: 20,left: 0,right: 0),
                            controller: _firstName,
                            validator: emptyStringValidator,
                            hintText: 'First Name',
                            labelText: 'Enter First Name',
                          ),
                          MyTextFormField(
                            padding: EdgeInsets.only(top: 20,left: 0,right: 0),
                            controller: _lastName,
                            validator: emptyStringValidator,
                            hintText: 'Last Name',
                            labelText: 'Enter Last Name',
                          ),
                          MyTextFormField(
                            padding: EdgeInsets.only(top: 20,left: 0,right: 0),
                            controller: _address,
                            validator: emptyStringValidator,
                            hintText: 'Address',
                            labelText: 'Enter Address',
                            maxLines: 2,
                          ),
                          MyTextFormField(
                            padding: EdgeInsets.only(top: 20,left: 0,right: 0),
                            textInputType: TextInputType.number,
                            controller: _cnic,
                            validator: emptyStringValidator,
                            hintText: 'CNIC',
                            labelText: 'Enter CNIC',
                            maxLength: 15,
                            onChanged: (value) {
                              String formattedText = _formatCnic(value);
                              _cnic.value = TextEditingValue(
                                text: formattedText,
                                selection: TextSelection.collapsed(
                                    offset: formattedText.length),
                              );
                            },
                          ),
                          MyTextFormField(
                            padding: EdgeInsets.all(0),
                            textInputType: TextInputType.phone,
                            controller: _mobile,
                            validator: emptyStringValidator,
                            hintText: 'Mobile No',
                            labelText: 'Enter Mobile No',
                          ),
                          MyTextFormField(
                            padding: EdgeInsets.only(top: 20,left: 0,right: 0),
                            controller: _email,
                            validator: emptyStringValidator,
                            hintText: 'Email',
                            labelText: 'Enter Email',
                          ),
                          MyPasswordTextFormField(
                            padding: EdgeInsets.only(top: 12,left: 0,right: 0),
                            maxLines: 1,
                            controller: _password,
                            obscureText: true,
                            togglePasswordView: () {},
                            validator: emptyStringValidator,
                            hintText: 'Password',
                            labelText: 'Password',
                          ),
                          30.0.ph,
                          MyButton(
                            gradient: AppGradients.buttonGradient,
                            onPressed: c.isSubmitting
                                ? null
                                : () {
                                    if (!_formKey.currentState!.validate()) return;
                                    c.addSubadmin(
                                      firstname: _firstName.text.trim(),
                                      lastname: _lastName.text.trim(),
                                      cnic: _cnic.text.trim(),
                                      password: _password.text.trim(),
                                      mobileno: _mobile.text.trim(),
                                      email: _email.text.trim(),
                                      address: _address.text.trim(),
                                    );
                                  },
                            loading: c.isSubmitting,
                            name: 'Save',
                          ),
                          20.0.ph,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
    });
  }

  String _formatCnic(String text) {
    text = text.replaceAll(RegExp(r'\D'), '');
    if (text.length > 13) {
      text = text.substring(0, 13);
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


