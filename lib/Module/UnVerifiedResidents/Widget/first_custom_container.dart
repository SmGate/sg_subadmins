import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

// ignore: must_be_immutable
class FirstCustomContainer extends StatelessWidget {
  FirstCustomContainer(
      {required this.ImageBaseUrl,
      required this.Name,
      required this.MobileNo,
      required this.Cnic,
      required this.VehicleNo,
      required this.ResidentalType,
      required this.Status,
      this.email});
  String? ImageBaseUrl;
  String? Name;
  String? MobileNo;
  String? Cnic;
  String? VehicleNo;
  String? ResidentalType;
  String? Status;
  String? email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageBuilder: (context, imageProvider) => Center(
            child: Container(
              width: 150.w,
              height: 150.w,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(ImageBaseUrl!))),
            ),
          ),
          imageUrl: ImageBaseUrl.toString(),
          placeholder: (context, url) => Column(
            children: [
              CircularProgressIndicator(
                color: AppColors.appThem,
              ),
            ],
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        16.ph,
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x3FACACAC),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Verification Details',
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF4A4A4A),
                    fontSize: 18.font,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 20),
                child: Text(
                  'Full Name',
                  style: GoogleFonts.ubuntu(
                    color: Color(0xFF4D4D4D),
                    fontSize: 14.font,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                ),
                child: Text(
                  Name!,
                  style: GoogleFonts.ubuntu(
                    color: Color(0xFF1A1A1A),
                    fontSize: 14.font,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              20.ph,
              Padding(
                padding: EdgeInsets.only(left: 31.w, top: 20),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // FULL NAME CNIC RESIDENTIAL TYPE
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cnic',
                            style: GoogleFonts.ubuntu(
                              color: Color(0xFF4D4D4D),
                              fontSize: 14.font,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          5.97.ph,
                          Text(
                            Cnic!,
                            style: GoogleFonts.ubuntu(
                              color: Color(0xFF1A1A1A),
                              fontSize: 14.font,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          20.ph,
                          Text(
                            'Residental Type',
                            style: GoogleFonts.ubuntu(
                              color: Color(0xFF4D4D4D),
                              fontSize: 14.font,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          5.97.ph,
                          Text(
                            ResidentalType!.toString(),
                            style: GoogleFonts.ubuntu(
                              color: Color(0xFF1A1A1A),
                              fontSize: 14.font,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          20.ph,
                          Text(
                            'Status',
                            style: GoogleFonts.ubuntu(
                              color: Color(0xFF4D4D4D),
                              fontSize: 14.font,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          5.97.ph,
                          if (int.parse(Status!) == 0) ...[
                            Text(
                              'Unverified',
                              style: GoogleFonts.ubuntu(
                                color: Color(0xFF1A1A1A),
                                fontSize: 14.font,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ]
                        ],
                      ),
                      80.pw,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact No',
                            style: GoogleFonts.ubuntu(
                              color: Color(0xFF4D4D4D),
                              fontSize: 14.font,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          5.97.ph,
                          Text(
                            MobileNo!.toString(),
                            style: GoogleFonts.ubuntu(
                              color: Color(0xFF1A1A1A),
                              fontSize: 14.font,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          20.ph,
                          Text(
                            'Vehicle No',
                            style: GoogleFonts.ubuntu(
                              color: Color(0xFF4D4D4D),
                              fontSize: 14.font,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          5.97.ph,
                          Text(
                            VehicleNo!.toString(),
                            style: GoogleFonts.ubuntu(
                              color: Color(0xFF1A1A1A),
                              fontSize: 14.font,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
