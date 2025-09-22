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
                _HeaderSummary(
                    count: c.subadmins.length, isLoading: c.isLoading),
                10.0.ph,
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
            child: const Icon(Icons.supervisor_account_rounded,
                color: Colors.white),
          ),
          12.0.pw,
          Expanded(
            child: Text(
              isLoading ? 'Loading subadmins…' : '$count Subadmin(s) found',
              style: TextStyle(
                color: AppColors.globalWhite,
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                shadows: const [
                  Shadow(
                      blurRadius: 2,
                      color: Colors.black26,
                      offset: Offset(0, 1))
                ],
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

  // ---------- Helpers ----------
  static String _getString(Map<String, dynamic> m, List<String> keys) {
    for (final k in keys) {
      final v = m[k];
      if (v != null) {
        final s = v.toString().trim();
        if (s.isNotEmpty) return s;
      }
    }
    return '';
  }

  /// Prefer firstname + lastname; else try common fallbacks; else derive from email.
  static String _bestDisplayName(Map<String, dynamic> m) {
    final first = _getString(m, ['firstname', 'first_name', 'firstName']);
    final last = _getString(m, ['lastname', 'last_name', 'lastName']);
    final fullFromPair =
        [first, last].where((e) => e.isNotEmpty).join(' ').trim();
    if (fullFromPair.isNotEmpty) return fullFromPair;

    final single = _getString(m, [
      'name',
      'full_name',
      'fullname',
      'display_name',
      'username',
      'user_name',
      'title'
    ]);
    if (single.isNotEmpty) return single;

    final email = _getString(m, ['email']);
    if (email.isNotEmpty && email.contains('@')) {
      return email
          .split('@')
          .first
          .replaceAll('.', ' ')
          .replaceAll('_', ' ')
          .trim();
    }
    return 'Subadmin';
  }

  /// Use as-is if already absolute; else prefix with Api.imageBaseUrl.
  static String _imageUrlFrom(Map<String, dynamic> m) {
    final raw =
        _getString(m, ['image', 'avatar', 'profile_image', 'profileImage']);
    if (raw.isEmpty) return '';
    final lower = raw.toLowerCase();
    // Avoid hitting known placeholder/invalid images that 404 on server
    final String fileName = lower.split('/').isNotEmpty ? lower.split('/').last : lower;
    const blockedFileNames = {
      'user.png',
      'avatar.png',
      'default.png',
    };
    if (blockedFileNames.contains(fileName) ||
        lower.contains('placeholder') ||
        lower.endsWith('/user.png') ||
        lower.endsWith('/avatar.png')) {
      return '';
    }
    if (lower.startsWith('http://') || lower.startsWith('https://')) return raw;
    return '${Api.imageBaseUrl}$raw';
  }

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
          style:
              TextStyle(color: AppColors.colorRed, fontWeight: FontWeight.w600),
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

        // Robust fields
        final displayName = _bestDisplayName(item);
        final email = _getString(item, ['email']);
        final phone =
            _getString(item, ['mobileno', 'mobile', 'phone', 'phone_number']);
        final address =
            _getString(item, ['address', 'location', 'societybuildingname']);
        final imageUrl = _imageUrlFrom(item);

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
            onTap: () {
              final int? subadminId = (item['subadminid'] as num?)?.toInt() ?? (item['id'] as num?)?.toInt();
              debugPrint('Selected subadminId: $subadminId');
              _openDetailDialog(context, item);
            },
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
                    child: imageUrl.isEmpty
                        ? Image.asset(AppImages.user, fit: BoxFit.cover)
                        : Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Image.asset(AppImages.user, fit: BoxFit.cover),
                          ),
                  ),
                  12.0.pw,

                  // Main info (ONLY: Name -> Email -> Phone -> Location)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Text(
                          displayName.isEmpty ? 'Subadmin' : displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.textBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        6.0.ph,

                        // Email
                        if (email.isNotEmpty)
                          _MutedText(
                            text: email,
                            icon: Icons.mail_outline_rounded,
                          ),

                        // Phone
                        if (phone.isNotEmpty) ...[
                          6.0.ph,
                          _MutedText(
                            text: phone,
                            icon: Icons.phone_iphone_rounded,
                          ),
                        ],

                        // Location
                        if (address.isNotEmpty) ...[
                          6.0.ph,
                          _MutedText(
                            text: address,
                            icon: Icons.location_on_outlined,
                            maxLines: 1,
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Trailing chevron
                  const Icon(Icons.chevron_right_rounded,
                      color: Colors.black54),
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
    final fullName = _bestDisplayName(item);
    final imageUrl = _imageUrlFrom(item);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          backgroundColor: AppColors.globalWhite,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                        child: imageUrl.isEmpty
                            ? Image.asset(AppImages.user, fit: BoxFit.cover)
                            : Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Image.asset(
                                    AppImages.user,
                                    fit: BoxFit.cover),
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
                            // Role/type chips intentionally removed from card,
                            // dialog keeps broader details below.
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
                      _DetailRow(
                          label: 'Email', value: _getString(item, ['email'])),
                      _DetailRow(
                          label: 'Phone',
                          value: _getString(item,
                              ['mobileno', 'mobile', 'phone', 'phone_number'])),
                      _DetailRow(
                          label: 'CNIC', value: _getString(item, ['cnic'])),
                      _DetailRow(
                          label: 'Address',
                          value: _getString(item, ['address', 'location'])),
                      _DetailRow(
                          label: 'Building Name',
                          value: _getString(item, ['societybuildingname'])),
                      _DetailRow(
                          label: 'Role',
                          value: _getString(item, ['rolename']).toUpperCase()),
                      _DetailRow(
                          label: 'Type', value: _getString(item, ['type'])),
                      _DetailRow(
                          label: 'Created',
                          value: _getString(item, ['created_at'])),
                      _DetailRow(
                          label: 'Updated',
                          value: _getString(item, ['updated_at'])),
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
                            final int? subadminId = (item['subadminid'] as num?)?.toInt() ?? (item['id'] as num?)?.toInt();
                            debugPrint('Navigate (Update Manager) subadminId: $subadminId');
                            Get.toNamed(updateSubadmin, arguments: item);
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            textStyle: const TextStyle(
                                fontSize: 12.5, fontWeight: FontWeight.w700),
                            side: BorderSide(color: AppColors.appThem),
                            foregroundColor: AppColors.appThem,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Update Manager'),
                        ),
                      ),
                      10.0.pw,
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(ctx).pop();
                            final int? subadminId = (item['subadminid'] as num?)?.toInt() ?? (item['id'] as num?)?.toInt();
                            debugPrint('Navigate (Update Building) subadminId: $subadminId');
                            Get.toNamed(updateSubadminBuilding, arguments: {
                              'item': item,
                              'user': ctrl.user,
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appThem,
                            foregroundColor: AppColors.globalWhite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            textStyle: const TextStyle(
                                fontSize: 12.5, fontWeight: FontWeight.w700),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
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
