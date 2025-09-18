// all_complaints_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Module/ViewReports/Model/get_all_complaints_model.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

import '../Controller/reported_resident_controller.dart';

//========== status helpers (enum for dropdown + labels)
enum ComplaintStatus { all, Completed, inProgress, pending }

extension _ComplaintStatusLabel on ComplaintStatus {
  String get label {
    switch (this) {
      case ComplaintStatus.all:
        return 'All';
      case ComplaintStatus.Completed:
        return 'Completed';
      case ComplaintStatus.inProgress:
        return 'In Progress';
      case ComplaintStatus.pending:
        return 'Pending';
    }
  }
}

// Keep API param mapping for dropdown filter hits
String _statusParam(ComplaintStatus s) {
  switch (s) {
    case ComplaintStatus.pending:
      return 'pending';
    case ComplaintStatus.inProgress:
      return 'in progress';
    case ComplaintStatus.Completed:
      return 'completed';
    case ComplaintStatus.all:
      return '';
  }
}

//================ ROBUST STATUS PARSING ==================
// We’ll parse either a string (statusDescription) or a number (status).
// Supported:
// - Strings: "completed", "in progress", "pending" (case-insensitive)
// - Int scheme A: 1=pending, 2=in progress, 3=completed
// - Int scheme B: 0=pending, 1=in progress, 2=completed

enum _ParsedStatus { pending, inProgress, completed, unknown }

_ParsedStatus _parseComplaintStatus({dynamic code, String? text}) {
  // Prefer descriptive text from API if present
  if (text != null) {
    final s = text.trim().toLowerCase();
    if (s.contains('complete')) return _ParsedStatus.completed;
    if (s.contains('progress')) return _ParsedStatus.inProgress;
    if (s.contains('pend')) return _ParsedStatus.pending;
  }

  // Fallback to numeric
  if (code is num) {
    final i = code.toInt();
    // Try scheme A (1/2/3)
    if (i == 1) return _ParsedStatus.pending;
    if (i == 2) return _ParsedStatus.inProgress;
    if (i == 3) return _ParsedStatus.completed;

    // Try scheme B (0/1/2)
    if (i == 0) return _ParsedStatus.pending;
    if (i == 1) return _ParsedStatus.inProgress;
    if (i == 2) return _ParsedStatus.completed;
  }

  return _ParsedStatus.unknown;
}

String _statusLabel(dynamic code, String? text) {
  switch (_parseComplaintStatus(code: code, text: text)) {
    case _ParsedStatus.pending:
      return 'pending';
    case _ParsedStatus.inProgress:
      return 'in progress';
    case _ParsedStatus.completed:
      return 'completed';
    case _ParsedStatus.unknown:
      return 'Unknown';
  }
}

class StatusColors {
  final Color bg;
  final Color fg;
  const StatusColors({required this.bg, required this.fg});
}

StatusColors _statusColors(dynamic code, String? text) {
  switch (_parseComplaintStatus(code: code, text: text)) {
    case _ParsedStatus.pending:
      return const StatusColors(
        bg: Color(0xFFFFF3E0),
        fg: Color(0xFFEF6C00),
      );
    case _ParsedStatus.inProgress:
      return const StatusColors(
        bg: Color(0xFFE3F2FD),
        fg: Color(0xFF1976D2),
      );
    case _ParsedStatus.completed:
      return const StatusColors(
        bg: Color(0xFFE8F5E9),
        fg: Color(0xFF2E7D32),
      );
    case _ParsedStatus.unknown:
      return const StatusColors(
        bg: Color(0xFFF5F5F5),
        fg: Color(0xFF616161),
      );
  }
}

//================ END ROBUST STATUS PARSING ==============

String _fmtDate(DateTime? d) {
  if (d == null) return '';
  final local = d.toLocal();
  String two(int n) => n.toString().padLeft(2, '0');
  return '${local.year}-${two(local.month)}-${two(local.day)} '
      '${two(local.hour)}:${two(local.minute)}';
}

class AllComplaintsTab extends StatefulWidget {
  const AllComplaintsTab({Key? key}) : super(key: key);

  @override
  State<AllComplaintsTab> createState() => _AllComplaintsTabState();
}

class _AllComplaintsTabState extends State<AllComplaintsTab> {
  final ResidentsListController ctl = Get.find<ResidentsListController>();

  // Default to "All" because first load is unfiltered
  ComplaintStatus _selected = ComplaintStatus.all;

  @override
  void initState() {
    super.initState();

    // Initial load (ALL — no status param)
    ctl.fetchAllComplaints(
      subadminId: ctl.userdata.subadminid ?? ctl.userdata.userid ?? 0,
      token: ctl.userdata.bearerToken ?? '',
    );
  }

  void _onStatusChanged(ComplaintStatus? val) {
    if (val == null) return;
    setState(() => _selected = val);

    // Map dropdown to API status and hit server (no local filtering)
    final status = (val == ComplaintStatus.all) ? null : _statusParam(val);
    ctl.setAllStatusAndReload(status);
  }

  void _openDetailDialog(ComplaintData c) {
    // Use robust parser: prefer c.statusDescription (string), fallback to c.status (int)
    final colors = _statusColors(c.status, c.statusDescription);
    final statusText = _statusLabel(c.status, c.statusDescription);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.globalWhite,
        surfaceTintColor: AppColors.globalWhite,
        title: Text(
          c.title ?? 'Complaint #${c.id ?? '-'}',
          style: GoogleFonts.ubuntu(fontWeight: FontWeight.w700),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //========== status pill
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: colors.bg,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  statusText,
                  style: GoogleFonts.ubuntu(
                    color: colors.fg,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text('ID: ${c.id ?? '-'}', style: GoogleFonts.ubuntu()),
              Text('User ID: ${c.userid ?? '-'}', style: GoogleFonts.ubuntu()),
              Text('Subadmin ID: ${c.subadminid ?? '-'}',
                  style: GoogleFonts.ubuntu()),
              const SizedBox(height: 8),
              Text('Created: ${_fmtDate(c.createdAt)}',
                  style: GoogleFonts.ubuntu()),
              Text('Updated: ${_fmtDate(c.updatedAt)}',
                  style: GoogleFonts.ubuntu()),
              const SizedBox(height: 12),
              Text('Description',
                  style: GoogleFonts.ubuntu(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(c.description ?? '-',
                  style: GoogleFonts.ubuntu(height: 1.35)),
              if (c.statusDescription != null &&
                  c.statusDescription!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text('Status Description',
                    style: GoogleFonts.ubuntu(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text(c.statusDescription!,
                    style: GoogleFonts.ubuntu(height: 1.35)),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close',
                style: GoogleFonts.ubuntu(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subadminId = ctl.userdata.subadminid ?? ctl.userdata.userid ?? 0;
    final token = ctl.userdata.bearerToken ?? '';

    return GetBuilder<ResidentsListController>(
      id: 'all', // listen to 'all' updates from ResidentsListController
      builder: (_) {
        return Column(
          children: [
            //========== status dropdown
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 4),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<ComplaintStatus>(
                  value: _selected,
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                  items: ComplaintStatus.values.map((s) {
                    return DropdownMenuItem(
                      value: s,
                      child: Text(s.label,
                          style: GoogleFonts.ubuntu(fontSize: 14)),
                    );
                  }).toList(),
                  onChanged: (ctl.allIsLoading) ? null : _onStatusChanged,
                ),
              ),
            ),

            //========== list + loaders (no pagination)
            if (ctl.allError != null && ctl.allError!.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  'Error: ${ctl.allError}',
                  style: GoogleFonts.ubuntu(color: Colors.red),
                ),
              ),

            Expanded(
              child: ctl.allIsLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: AppColors.appThem,
                    ))
                  : RefreshIndicator(
                      onRefresh: () => ctl.fetchAllComplaints(
                        subadminId: subadminId,
                        token: token,
                      ),
                      child: ctl.allComplaints.isEmpty
                          ? Center(
                              child: Text(
                                (_selected == ComplaintStatus.all)
                                    ? 'No complaints found.'
                                    : 'No complaints for "${_selected.label}".',
                                style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              itemCount: ctl.allComplaints.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final c = ctl.allComplaints[index];

                                // Use robust label/colors using string or int
                                final statusText =
                                    _statusLabel(c.status, c.statusDescription);
                                final colors = _statusColors(
                                    c.status, c.statusDescription);

                                final created = _fmtDate(c.createdAt);

                                final desc = (c.description ?? '').trim();
                                final preview = desc.length > 80
                                    ? '${desc.substring(0, 80)}...'
                                    : desc;

                                return _ComplaintCard(
                                  title: c.title ?? 'Complaint #${c.id ?? '-'}',
                                  subTitle: preview.isEmpty
                                      ? 'ID: ${c.id ?? '-'}'
                                      : preview,
                                  meta: 'Created: $created',
                                  detail: c.statusDescription ?? '',
                                  buttonText: 'View Details',
                                  buttonColor: AppColors.appThem,
                                  onPressed: () => _openDetailDialog(c),
                                  statusLabel: statusText,
                                  statusBg: colors.bg,
                                  statusFg: colors.fg,
                                );
                              },
                            ),
                    ),
            ),
          ],
        );
      },
    );
  }
}

/// A self-contained card with the status pill INSIDE it (no image).
class _ComplaintCard extends StatelessWidget {
  const _ComplaintCard({
    required this.title,
    required this.subTitle,
    required this.meta,
    required this.detail,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
    this.statusLabel,
    this.statusBg,
    this.statusFg,
  });

  final String title;
  final String subTitle; // description preview or fallback
  final String meta; // small meta line e.g., created date
  final String detail; // status description or extra line
  final String buttonText;
  final Color buttonColor;
  final VoidCallback onPressed;

  final String? statusLabel;
  final Color? statusBg;
  final Color? statusFg;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: AppColors.globalWhite,
      color: AppColors.globalWhite,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              Text(
                title,
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),

              // subtitle / preview
              Text(
                subTitle,
                style: GoogleFonts.ubuntu(
                  fontSize: 13.5,
                  height: 1.3,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),

              // meta
              Text(
                meta,
                style: GoogleFonts.ubuntu(
                  fontSize: 12.5,
                  color: Colors.black54,
                ),
              ),

              // status pill inside card
              if (statusLabel != null && statusLabel!.trim().isNotEmpty) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusBg ?? const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    statusLabel!,
                    style: GoogleFonts.ubuntu(
                      color: statusFg ?? const Color(0xFF616161),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 12),

              // button
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: onPressed,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
