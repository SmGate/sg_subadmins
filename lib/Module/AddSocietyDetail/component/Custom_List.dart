import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomList extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final String? text2;
  final String? text3;
  final String? text4;
  final String? label2;
  final String? label3;

  const CustomList({
    Key? key,
    required this.onTap,
    required this.text,
    this.text2,
    this.text3,
    this.text4,
    this.label2,
    this.label3,
  }) : super(key: key);

  bool _isNotEmpty(String? value) => value != null && value.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.1),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Future.delayed(Duration(milliseconds: 100), onTap);
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_isNotEmpty(text))
                        Text(
                          text!,
                          style: GoogleFonts.ubuntu(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                        ),
                      if (_isNotEmpty(text3))
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Row(
                            children: [
                              if (_isNotEmpty(label3))
                                Text(
                                  "${label3!}: ",
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              Expanded(
                                child: Text(
                                  text3!,
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (_isNotEmpty(text2))
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            children: [
                              if (_isNotEmpty(label2))
                                Text(
                                  "${label2!}: ",
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              Expanded(
                                child: Text(
                                  text2!,
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (_isNotEmpty(text4))
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            text4!,
                            style: GoogleFonts.ubuntu(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
