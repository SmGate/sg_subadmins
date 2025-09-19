import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/Widgets/my_textform_field.dart';
import 'package:societyadminapp/Widgets/my_password_textform_field.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/utils/Constants/constants.dart';

class UpdateSubadminScreen extends StatefulWidget {
  const UpdateSubadminScreen({Key? key}) : super(key: key);

  @override
  State<UpdateSubadminScreen> createState() => _UpdateSubadminScreenState();
}

class _UpdateSubadminScreenState extends State<UpdateSubadminScreen> {
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
    final Map<String, dynamic>? item = Get.arguments as Map<String, dynamic>?;

    _firstName.text = item?['firstname']?.toString() ?? '';
    _lastName.text = item?['lastname']?.toString() ?? '';
    _address.text = item?['address']?.toString() ?? '';
    _mobile.text = item?['mobileno']?.toString() ?? '';
    _cnic.text = item?['cnic']?.toString() ?? '';
    _email.text = item?['email']?.toString() ?? '';

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyBackButton(text: 'Update Manager', onTap: () => Get.back()),
                20.0.ph,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      MyTextFormField(
                        padding: const EdgeInsets.only(top: 20),
                        controller: _firstName,
                        validator: emptyStringValidator,
                        hintText: 'First Name',
                        labelText: 'Enter First Name',
                      ),
                      MyTextFormField(
                        padding: const EdgeInsets.only(top: 20),
                        controller: _lastName,
                        validator: emptyStringValidator,
                        hintText: 'Last Name',
                        labelText: 'Enter Last Name',
                      ),
                      MyTextFormField(
                        padding: const EdgeInsets.only(top: 20),
                        controller: _address,
                        validator: emptyStringValidator,
                        hintText: 'Address',
                        labelText: 'Enter Address',
                        maxLines: 2,
                      ),
                      MyTextFormField(
                        padding: const EdgeInsets.only(top: 20),
                        controller: _mobile,
                        validator: emptyStringValidator,
                        hintText: 'Mobile No',
                        labelText: 'Enter Mobile No',
                        textInputType: TextInputType.phone,
                      ),
                      MyTextFormField(
                        padding: const EdgeInsets.only(top: 20),
                        controller: _cnic,
                        validator: emptyStringValidator,
                        hintText: 'CNIC',
                        labelText: 'Enter CNIC',
                        textInputType: TextInputType.number,
                        maxLength: 15,
                      ),
                      MyTextFormField(
                        padding: const EdgeInsets.only(top: 20),
                        controller: _email,
                        validator: emptyStringValidator,
                        hintText: 'Email',
                        labelText: 'Enter Email',
                      ),
                      MyPasswordTextFormField(
                        padding: const EdgeInsets.only(top: 12),
                        maxLines: 1,
                        controller: _password,
                        obscureText: true,
                        togglePasswordView: () {},
                        validator: emptyStringValidator,
                        hintText: 'Password (optional)',
                        labelText: 'Password (optional)',
                      ),
                      30.0.ph,
                      MyButton(
                        gradient: AppGradients.buttonGradient,
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;
                          Get.back();
                        },
                        name: 'Save',
                      ),
                      20.0.ph,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


