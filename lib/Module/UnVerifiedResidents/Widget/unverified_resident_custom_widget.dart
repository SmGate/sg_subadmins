import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

class UnverifiedCard extends StatefulWidget {
  const UnverifiedCard({
    Key? key,
    required this.onTap,
    required this.name,
    required this.mobileno,
    required this.onRejectTap, // ← takes reason & runs API
  }) : super(key: key);

  final VoidCallback? onTap;
  final Future<void> Function(String reason) onRejectTap;
  final String name;
  final String mobileno;

  @override
  State<UnverifiedCard> createState() => _UnverifiedCardState();
}

class _UnverifiedCardState extends State<UnverifiedCard> {
  bool _isRejecting = false;

  void _openRejectDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          title: Text(
            'Reject Reason',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16.font,
              color: AppColors.textBlack,
            ),
          ),
          content: SizedBox(
            width: 300.w,
            child: TextField(
              controller: controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Add reason...',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12.font,
                  color: const Color(0xFF9E9E9E),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                isDense: true,
              ),
            ),
          ),
          actionsPadding: EdgeInsets.only(right: 12.w, bottom: 8.h),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child:
                  Text('Cancel', style: GoogleFonts.poppins(fontSize: 12.font)),
            ),
            TextButton(
              onPressed: _isRejecting
                  ? null
                  : () async {
                      final reason = controller.text.trim();
                      if (reason.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please enter a reason')),
                        );
                        return;
                      }
                      Navigator.of(ctx).pop(); // close dialog first

                      setState(() => _isRejecting = true);
                      try {
                        await widget
                            .onRejectTap(reason); // ← API call in parent
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Rejected successfully')),
                        );
                      } catch (e) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed: $e')),
                        );
                      } finally {
                        if (mounted) setState(() => _isRejecting = false);
                      }
                    },
              child: Text('OK', style: GoogleFonts.poppins(fontSize: 12.font)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.h.ph,
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(16.w, 1.w, 16.w, 0),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.25, color: AppColors.appThem),
              borderRadius: BorderRadius.circular(8.r),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3D000000),
                blurRadius: 1,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 180.w,
                      child: Text(
                        widget.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: AppColors.textBlack,
                          fontSize: 16.font,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      widget.mobileno,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFB8B8B8),
                        fontSize: 12.font,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                const Spacer(),
                // Action buttons: Reject + Unverified
                Column(
                  children: [
                    // Reject button (opens dialog)
                    GestureDetector(
                      onTap: _isRejecting
                          ? null
                          : () => _openRejectDialog(context),
                      child: Container(
                        width: 100.w,
                        height: 30.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.redAccent, width: 1),
                          color: Colors.white,
                        ),
                        child: _isRejecting
                            ? SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.redAccent,
                                ),
                              )
                            : Text(
                                'Reject',
                                style: GoogleFonts.poppins(
                                  fontSize: 10.font,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.redAccent,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 10.w),
                    // Existing Unverified button
                    GestureDetector(
                      onTap: _isRejecting ? null : widget.onTap,
                      child: MyButton(
                        gradient: AppGradients.buttonGradient,
                        name: 'Unverified',
                        width: 100.w,
                        height: 30.h,
                        fontSize: 10.font,
                        fontWeight: FontWeight.w500,
                        border: 8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        20.ph,
      ],
    );
  }
}
