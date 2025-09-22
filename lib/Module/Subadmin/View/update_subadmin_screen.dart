import 'package:societyadminapp/Module/Subadmin/Controller/subadmin_list_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/Widgets/my_textform_field.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';

class UpdateSubadminScreen extends StatefulWidget {
  const UpdateSubadminScreen({Key? key}) : super(key: key);

  @override
  State<UpdateSubadminScreen> createState() => _UpdateSubadminScreenState();
}

class _UpdateSubadminScreenState extends State<UpdateSubadminScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _cnic = TextEditingController();
  final _password = TextEditingController();
  final _mobile = TextEditingController();
  final _address = TextEditingController();

  Map<String, dynamic>? _item;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      _item = args;
    }
    _firstName.text = (_item?['firstname'] ?? '').toString();
    _lastName.text = (_item?['lastname'] ?? '').toString();
    _email.text = (_item?['email'] ?? '').toString();
    _mobile.text = (_item?['mobileno'] ?? _item?['mobile'] ?? '').toString();
    _address.text = (_item?['address'] ?? '').toString();
    _cnic.text = (_item?['cnic'] ?? '').toString();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _cnic.dispose();
    _password.dispose();
    _mobile.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                8.0.ph,
                MyBackButton(
                  text: 'Update Manager',
                  onTap: () => Get.back(),
                ),
                18.0.ph,
                _HeaderCard(
                  title: '${_item?['firstname'] ?? ''} ${_item?['lastname'] ?? ''}'.trim().isEmpty
                      ? 'Subadmin'
                      : '${_item?['firstname'] ?? ''} ${_item?['lastname'] ?? ''}'.trim(),
                  subtitle: 'Edit manager basic details.',
                ),
                16.0.ph,
                Text(
                  'First Name',
                  style: TextStyle(
                    color: AppColors.boldHeading,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                6.0.ph,
                MyTextFormField(
                  width: double.infinity,
                  padding: EdgeInsets.zero,
                  controller: _firstName,
                  hintText: 'First Name',
                  labelText: 'First Name',
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                14.0.ph,
                Text(
                  'Last Name',
                  style: TextStyle(
                    color: AppColors.boldHeading,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                6.0.ph,
                MyTextFormField(
                  padding: EdgeInsets.zero,
                  width: double.infinity,
                  controller: _lastName,
                  hintText: 'Last Name',
                  labelText: 'Last Name',
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                14.0.ph,
                Text(
                  'Email',
                  style: TextStyle(
                    color: AppColors.boldHeading,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                6.0.ph,
                MyTextFormField(
                  padding: EdgeInsets.zero,
                  width: double.infinity,
                  controller: _email,
                  hintText: 'Email',
                  labelText: 'Email',
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                14.0.ph,
                Text(
                  'CNIC',
                  style: TextStyle(
                    color: AppColors.boldHeading,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                6.0.ph,
                MyTextFormField(
                  padding: EdgeInsets.zero,
                  width: double.infinity,
                  controller: _cnic,
                  hintText: 'CNIC',
                  labelText: 'CNIC',
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                14.0.ph,
                Text(
                  'Password',
                  style: TextStyle(
                    color: AppColors.boldHeading,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                6.0.ph,
                MyTextFormField(
                  padding: EdgeInsets.zero,
                  width: double.infinity,
                  controller: _password,
                  hintText: 'Password',
                  labelText: 'Password',
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                14.0.ph,
                Text(
                  'Mobile',
                  style: TextStyle(
                    color: AppColors.boldHeading,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                6.0.ph,
                MyTextFormField(
                  padding: EdgeInsets.zero,
                  width: double.infinity,
                  controller: _mobile,
                  hintText: 'Mobile',
                  labelText: 'Mobile',
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                14.0.ph,
                Text(
                  'Address',
                  style: TextStyle(
                    color: AppColors.boldHeading,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                6.0.ph,
                MyTextFormField(
                  padding: EdgeInsets.zero,
                  width: double.infinity,
                  controller: _address,
                  hintText: 'Address',
                  labelText: 'Address',
                  maxLines: 2,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                22.0.ph,
                Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: GetBuilder<SubadminListController>(
                      init: SubadminListController(),
                      builder: (c) => MyButton(
                      gradient: AppGradients.buttonGradient,
                      name: 'Save',
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        final int? subadminId = (_item?['subadminid'] as num?)?.toInt() ?? (_item?['id'] as num?)?.toInt();
                        if (subadminId == null) {
                          Get.snackbar('Error', 'Missing subadmin ID');
                          return;
                        }
                        c.updateSubadmin(
                          subadminId: subadminId,
                          firstname: _firstName.text.trim(),
                          lastname: _lastName.text.trim(),
                          cnic: _cnic.text.trim(),
                          password: _password.text.trim(),
                          mobileno: _mobile.text.trim(),
                          address: _address.text.trim(),
                          email: _email.text.trim(),
                        ).then((msg) {
                          if (msg != null) {
                            Get.snackbar('Success', msg);
                            Get.offAllNamed(homescreen, arguments: c.user);
                          }
                        });
                      },
                      loading: c.isSubmitting,
                    )),
                  ),
                ),
                20.0.ph,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const _HeaderCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.appThem, AppColors.blue],
    );

    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.manage_accounts_rounded, color: Colors.white),
          ),
          12.0.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.globalWhite,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    height: 1.2,
                    shadows: const [
                      Shadow(blurRadius: 2, color: Colors.black26, offset: Offset(0, 1)),
                    ],
                  ),
                ),
                4.0.ph,
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.globalWhite.withOpacity(0.98),
                    fontSize: 12.5,
                    height: 1.25,
                    shadows: const [
                      Shadow(blurRadius: 2, color: Colors.black26, offset: Offset(0, 1)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


