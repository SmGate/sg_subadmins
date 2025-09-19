import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Model/User.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/Module/Subadmin/Controller/subadmin_list_controller.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';

class SubadminListScreen extends GetView<SubadminListController> {
  const SubadminListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = Get.arguments is User ? Get.arguments as User : User();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.appThem,
          foregroundColor: AppColors.globalWhite,
          onPressed: () async {
            await Get.toNamed(addSubadmin, arguments: user);
            if (Get.isRegistered<SubadminListController>()) {
              Get.find<SubadminListController>().fetchSubadmins();
            }
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Subadmin'),
        ),
        body: GetBuilder<SubadminListController>(
          init: SubadminListController(user: user),
          builder: (c) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                  child: MyBackButton(
                    text: 'Subadmins',
                    onTap: () => Get.offAndToNamed(homescreen, arguments: user),
                  ),
                ),
                10.0.ph,

                // Header summary card (optional but nice polish)
                _HeaderSummary(count: c.subadmins.length, isLoading: c.isLoading),

                10.0.ph,
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: _SubadminList(
                      subadmins: c.subadmins,
                      isLoading: c.isLoading,
                      error: c.errorMessage,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// --- Header summary card (lightweight polish)
class _HeaderSummary extends StatelessWidget {
  final int count;
  final bool isLoading;
  const _HeaderSummary({required this.count, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.appThem, AppColors.blue],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.supervisor_account_rounded, color: Colors.white),
          ),
          12.0.pw,
          Expanded(
            child: Text(
              isLoading ? 'Loading subadmins…' : '$count Subadmin(s) found',
              style: TextStyle(
                color: AppColors.globalWhite,
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                shadows: const [Shadow(blurRadius: 2, color: Colors.black26, offset: Offset(0, 1))],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubadminList extends StatelessWidget {
  final List<Map<String, dynamic>> subadmins;
  final bool isLoading;
  final String? error;

  const _SubadminList({
    Key? key,
    required this.subadmins,
    required this.isLoading,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 180),
        child: Center(
          child: CircularProgressIndicator(color: AppColors.appThem),
        ),
      );
    }

    if (error != null && error!.isNotEmpty) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Text(
          error!,
          style: TextStyle(color: AppColors.colorRed, fontWeight: FontWeight.w600),
        ),
      );
    }

    if (subadmins.isEmpty) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Text(
          'No subadmins added yet.',
          style: TextStyle(color: AppColors.dark),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subadmins.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = subadmins[index];
        final fullName = '${item['firstname'] ?? ''} ${item['lastname'] ?? ''}'.trim();
        final role = (item['rolename']?.toString() ?? 'subadmin').toUpperCase();
        final type = (item['type']?.toString() ?? '');
        final imageUrl = '${Api.imageBaseUrl}${item['image'] ?? ''}';

        return Container(
          decoration: BoxDecoration(
            color: AppColors.globalWhite,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => _openDetailDialog(context, item),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.black.withOpacity(0.05),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(AppImages.user, fit: BoxFit.cover),
                    ),
                  ),
                  12.0.pw,

                  // Main info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name + role chip line
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                fullName.isEmpty ? 'Subadmin' : fullName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.textBlack,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            8.0.pw,
                            _ChipSmall(text: role),
                            if (type.isNotEmpty) ...[
                              6.0.pw,
                              _ChipSmall(text: type),
                            ],
                          ],
                        ),
                        6.0.ph,
                        // Email + Phone (condensed)
                        Row(
                          children: [
                            Expanded(
                              child: _MutedText(
                                text: item['email']?.toString() ?? '',
                                icon: Icons.mail_outline_rounded,
                              ),
                            ),
                            8.0.pw,
                            Expanded(
                              child: _MutedText(
                                text: item['mobileno']?.toString() ?? '',
                                icon: Icons.phone_iphone_rounded,
                              ),
                            ),
                          ],
                        ),
                        6.0.ph,
                        _MutedText(
                          text: item['address']?.toString() ?? '',
                          icon: Icons.location_on_outlined,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),

                  // Trailing chevron
                  const Icon(Icons.chevron_right_rounded, color: Colors.black54),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _openDetailDialog(BuildContext context, Map<String, dynamic> item) {
    final ctrl = Get.find<SubadminListController>();
    final fullName = '${item['firstname'] ?? ''} ${item['lastname'] ?? ''}'.trim();
    final imageUrl = '${Api.imageBaseUrl}${item['image'] ?? ''}';

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          backgroundColor: AppColors.globalWhite,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gradient header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.appThem, AppColors.blue],
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Image.asset(AppImages.user, fit: BoxFit.cover),
                        ),
                      ),
                      12.0.pw,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullName.isEmpty ? 'Subadmin' : fullName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.globalWhite,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                shadows: const [
                                  Shadow(
                                      blurRadius: 2,
                                      color: Colors.black26,
                                      offset: Offset(0, 1)),
                                ],
                              ),
                            ),
                            6.0.ph,
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: [
                                _ChipSmall(text: (item['rolename']?.toString() ?? 'SUBADMIN').toUpperCase(), inverted: true),
                                if ((item['type']?.toString() ?? '').isNotEmpty)
                                  _ChipSmall(text: item['type'].toString(), inverted: true),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Body
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _DetailRow(label: 'Email', value: item['email']?.toString() ?? ''),
                      _DetailRow(label: 'Phone', value: item['mobileno']?.toString() ?? ''),
                      _DetailRow(label: 'CNIC', value: item['cnic']?.toString() ?? ''),
                      _DetailRow(label: 'Address', value: item['address']?.toString() ?? ''),
                      _DetailRow(label: 'Building Name', value: item['societybuildingname']?.toString() ?? ''),
                      _DetailRow(label: 'Created', value: item['created_at']?.toString() ?? ''),
                      _DetailRow(label: 'Updated', value: item['updated_at']?.toString() ?? ''),
                      12.0.ph,
                    ],
                  ),
                ),

                const Divider(height: 1),

                // Actions
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            Get.toNamed(updateSubadmin, arguments: item);
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
                            side: BorderSide(color: AppColors.appThem),
                            foregroundColor: AppColors.appThem,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Update Manager'),
                        ),
                      ),
                      10.0.pw,
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            Get.toNamed(updateSubadminBuilding, arguments: {
                              'item': item,
                              'user': ctrl.user,
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appThem,
                            foregroundColor: AppColors.globalWhite,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Update Building'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// --- Small components

class _ChipSmall extends StatelessWidget {
  final String text;
  final bool inverted; // true for white text/outlined on gradient bg
  const _ChipSmall({required this.text, this.inverted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: inverted ? Colors.white.withOpacity(0.18) : Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: inverted
            ? Border.all(color: Colors.white.withOpacity(0.55), width: 1)
            : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: inverted ? AppColors.globalWhite : AppColors.textBlack,
        ),
      ),
    );
  }
}

class _MutedText extends StatelessWidget {
  final String text;
  final IconData? icon;
  final int maxLines;
  const _MutedText({required this.text, this.icon, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    final child = Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppColors.dark,
        fontSize: 12.5,
        height: 1.25,
      ),
    );

    if (icon == null) return child;

    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black54),
        const SizedBox(width: 6),
        Expanded(child: child),
      ],
    );
    }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                color: AppColors.boldHeading,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
          8.0.pw,
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.textBlack,
                fontSize: 13,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _labeled(String label, String value) {
  // (Kept for compatibility if somewhere else uses it)
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(text: label, style: const TextStyle(fontWeight: FontWeight.w700)),
        TextSpan(text: value),
      ],
    ),
  );
}
