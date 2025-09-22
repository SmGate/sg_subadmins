import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Model/User.dart';
import 'package:societyadminapp/Module/Subadmin/Controller/subadmin_list_controller.dart';
import 'package:societyadminapp/Routes/set_routes.dart';

class UpdateSubadminBuildingScreen extends StatefulWidget {
  const UpdateSubadminBuildingScreen({Key? key}) : super(key: key);

  @override
  State<UpdateSubadminBuildingScreen> createState() =>
      _UpdateSubadminBuildingScreenState();
}

class _UpdateSubadminBuildingScreenState
    extends State<UpdateSubadminBuildingScreen> {
  int? selectedBuildingId;
  Map<String, dynamic>? _item;
  User? _user;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map) {
      _item =
          args['item'] as Map<String, dynamic>? ?? (args as Map<String, dynamic>);
      _user = args['user'] as User?;
    } else if (args is Map<String, dynamic>) {
      _item = args;
    }
    _startLoad();
  }

  Future<void> _startLoad() async {
    setState(() {
      selectedBuildingId = null;
    });
    final int sid = _resolveSocietyId();
    if (sid != 0) {
      final SubadminListController c = Get.isRegistered<SubadminListController>()
          ? Get.find<SubadminListController>()
          : Get.put(SubadminListController(user: _user));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        c.fetchBuildingsForSociety(sid);
      });
    }
  }

  int _resolveSocietyId() {
    int societyId = 0;
    final dynamic candidate = _item?['societyid'] ??
        _item?['society_id'] ??
        (_item is Map<String, dynamic>
            ? (_item!['society'] is Map
                ? (_item!['society'] as Map)['id']
                : null)
            : null) ??
        _user?.societyid;
    if (candidate is num) societyId = candidate.toInt();
    return societyId;
  }

  @override
  Widget build(BuildContext context) {
    final String managerName =
        '${_item?['firstname'] ?? ''} ${_item?['lastname'] ?? ''}'.trim();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: MyBackButton(
                text: 'Update Building',
                onTap: () => Get.back(),
              ),
            ),
            8.0.ph,

            _HeaderCard(
              title: managerName.isEmpty ? 'Subadmin' : managerName,
              subtitle:
                  'Assign or change the building for this subadmin/manager.',
            ),
            12.0.ph,

            Expanded(
              child: GetBuilder<SubadminListController>(
                builder: (c) {
                  final List<Map<String, dynamic>> buildings = c.buildings;
                  final bool loading = c.isBuildingsLoading;
                  // Preselect if not selected yet and item has assignment
                  if (selectedBuildingId == null && buildings.isNotEmpty) {
                    final dynamic currentBuildingId = _item?['societybuildingid'] ?? _item?['buildingid'];
                    if (currentBuildingId is num) {
                      final int id = currentBuildingId.toInt();
                      final bool exists = buildings.any((b) => (b['id'] as num?)?.toInt() == id);
                      if (exists) {
                        selectedBuildingId = id;
                      }
                    }
                  }
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionTitle('Select Building'),
                        8.0.ph,
                        loading
                            ? const _DropdownSkeleton()
                            : _SlimDropdown(
                                value: selectedBuildingId,
                                items: buildings
                                    .map((b) => DropdownMenuItem<int>(
                                          value: (b['id'] as num).toInt(),
                                          child: Text(
                                            b['societybuildingname']?.toString() ?? 'Building',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (v) => setState(() {
                                  selectedBuildingId = v;
                                  debugPrint('Selected buildingId: $v');
                                }),
                              ),
                        18.0.ph,
                        _HintTile(
                          icon: Icons.info_outline_rounded,
                          text: 'Only buildings from the selected society are listed. Tap Save to apply.',
                        ),
                        26.0.ph,
                        Align(
                          alignment: Alignment.center,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 280),
                            child: MyButton(
                              gradient: AppGradients.buttonGradient,
                              onPressed: () async {
                                if (c.isSubmitting) return;
                                if (selectedBuildingId == null) {
                                  Get.snackbar('Validation', 'Building must be selected');
                                  return;
                                }
                                final int? buildingId = selectedBuildingId;
                                final int? subadminId = (_item?['subadminid'] as num?)?.toInt() ?? (_item?['id'] as num?)?.toInt();
                                if (buildingId == null || subadminId == null) {
                                  Get.snackbar('Error', 'Missing required identifiers');
                                  return;
                                }
                                final String? msg = await c.assignBuildingToSubadmin(
                                  subadminId: subadminId,
                                  buildingId: buildingId,
                                );
                                if (msg != null) {
                                  Get.snackbar('Success', msg);
                                  // Go to Home and clear all routes
                                  Get.offAllNamed(homescreen, arguments: _user ?? c.user);
                                }
                              },
                              loading: c.isSubmitting,
                              name: 'Save',
                            ),
                          ),
                        ),
                        14.0.ph,
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadBuildings(
      Map<String, dynamic>? item, User? user) async {
    try {
      int societyId = 0;
      final dynamic candidate = item?['societyid'] ??
          item?['society_id'] ??
          (item is Map<String, dynamic>
              ? (item['society'] is Map
                  ? (item['society'] as Map)['id']
                  : null)
              : null) ??
          user?.societyid;
      if (candidate is num) societyId = candidate.toInt();

      if (societyId == 0) {
        return;
      }
      final ctrl = Get.find<SubadminListController>();
      await ctrl.fetchBuildingsForSociety(societyId);

      // Preselect existing assignment if provided
      final dynamic currentBuildingId = item?['societybuildingid'] ?? item?['buildingid'];
      if (currentBuildingId is num) {
        final int id = currentBuildingId.toInt();
        final bool exists = ctrl.buildings.any((b) => (b['id'] as num?)?.toInt() == id);
        if (exists) {
          setState(() {
            selectedBuildingId = id;
          });
        }
      }
    } catch (_) {}
  }
}

/// -------------------- UI PIECES (only your AppColors used) --------------------

class _HeaderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const _HeaderCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    // 🔥 High-contrast gradient from your palette (no faded look)
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.appThem, // teal-ish
        AppColors.blue,    // deep blue
      ],
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
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
            child:
                const Icon(Icons.person_pin_circle_rounded, color: Colors.white),
          ),
          12.0.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // brighter, with subtle shadow for readability
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

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.boldHeading,
        fontWeight: FontWeight.w800,
        fontSize: 14.5,
        letterSpacing: 0.2,
      ),
    );
  }
}

class _SlimDropdown extends StatelessWidget {
  final int? value;
  final List<DropdownMenuItem<int>> items;
  final ValueChanged<int?> onChanged;

  const _SlimDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.black.withOpacity(0.08),
        width: 1,
      ),
    );

    return DropdownButtonFormField<int>(
      value: value,
      isExpanded: true,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: AppColors.globalWhite,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        hintText: 'Choose building',
        hintStyle: TextStyle(
          color: AppColors.dark,
          fontSize: 13.5,
        ),
        prefixIcon:
            Icon(Icons.apartment_rounded, size: 20, color: AppColors.dark),
        suffixIcon: const Icon(Icons.expand_more_rounded, size: 20),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(
            color: AppColors.appThem.withOpacity(0.7),
            width: 1.2,
          ),
        ),
      ),
      iconSize: 0,
      style: TextStyle(
        color: AppColors.textBlack,
        fontSize: 13.8,
        fontWeight: FontWeight.w600,
      ),
      dropdownColor: AppColors.globalWhite,
    );
  }
}

class _HintTile extends StatelessWidget {
  final IconData icon;
  final String text;
  const _HintTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.tintGreen.withOpacity(0.28),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.green.withOpacity(0.35),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.green),
          8.0.pw,
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: AppColors.textBlack.withOpacity(0.85),
                fontSize: 12.5,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DropdownSkeleton extends StatelessWidget {
  const _DropdownSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          12.0.pw,
          Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.06),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          10.0.pw,
          Expanded(
            child: Container(
              height: 12,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.06),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          10.0.pw,
          Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.06),
              shape: BoxShape.circle,
            ),
          ),
          12.0.pw,
        ],
      ),
    );
  }
}
