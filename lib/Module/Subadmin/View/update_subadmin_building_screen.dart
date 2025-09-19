import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:http/http.dart' as Http;
import 'dart:convert';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/Model/User.dart';

class UpdateSubadminBuildingScreen extends StatefulWidget {
  const UpdateSubadminBuildingScreen({Key? key}) : super(key: key);

  @override
  State<UpdateSubadminBuildingScreen> createState() =>
      _UpdateSubadminBuildingScreenState();
}

class _UpdateSubadminBuildingScreenState
    extends State<UpdateSubadminBuildingScreen> {
  int? selectedBuildingId;
  List<Map<String, dynamic>> buildings = [];
  bool loading = false;
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
    setState(() => loading = true);
    await _loadBuildings(_item, _user);
    if (selectedBuildingId == null && buildings.isNotEmpty) {
      final dynamic firstId = buildings.first['id'];
      if (firstId is num) selectedBuildingId = firstId.toInt();
    }
    setState(() => loading = false);
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
              child: SingleChildScrollView(
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
                                        b['societybuildingname']?.toString() ??
                                            'Building',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (v) => setState(() {
                              selectedBuildingId = v;
                            }),
                          ),
                    18.0.ph,
                    _HintTile(
                      icon: Icons.info_outline_rounded,
                      text:
                          'Only buildings from the selected society are listed. Tap Save to apply.',
                    ),
                    26.0.ph,

                    // ✅ Centered Save button with a nice max width
                    Align(
                      alignment: Alignment.center,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 280),
                        child: MyButton(
                          gradient: AppGradients.buttonGradient,
                          onPressed: selectedBuildingId == null
                              ? null
                              : () => Get.back(),
                          name: 'Save',
                        ),
                      ),
                    ),

                    14.0.ph,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _loadBuildings(
      Map<String, dynamic>? item, User? user) async {
    if (buildings.isNotEmpty) return buildings;
    try {
      final int societyId = (item?['societyid'] as num?)?.toInt() ?? 0;
      final res = await Http.get(
        Uri.parse('${Api.getBuildings}/$societyId'),
        headers: <String, String>{
          'Accept': 'application/json',
          if (user?.bearerToken != null)
            'Authorization': 'Bearer ${user!.bearerToken}',
        },
      );
      if (res.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(res.body);
        final List<dynamic> data = (body['data'] as List?) ?? <dynamic>[];
        buildings = data
            .map<Map<String, dynamic>>(
                (e) => Map<String, dynamic>.from(e as Map))
            .toList();
      }
    } catch (_) {}
    return buildings;
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
