// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

class CustomImagePicker extends StatelessWidget {
  CustomImagePicker({
    required this.backgroundImage,
    required this.camOnPressed,
    required this.galOnPressed,
  });
  ImageProvider<Object>? backgroundImage;
  void Function()? camOnPressed;
  void Function()? galOnPressed;
  bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CircleAvatar(
            radius: 50.0.r,
            backgroundColor: AppColors.background,
            backgroundImage: backgroundImage),
        Positioned(
          left: isTablet(context) ? 50.w : 65.w,
          top: 65.h,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: AppColors.globalWhite,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 100.0.h,
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.w),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Choose Profile Photo',
                            style: TextStyle(fontSize: ScreenUtil().setSp(20)),
                          ),
                          20.ph,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.appThem),
                                icon: Icon(
                                  Icons.camera,
                                  color: AppColors.globalWhite,
                                ),
                                onPressed: camOnPressed,
                                label: Text(
                                  'Camera',
                                  style: TextStyle(
                                    color: AppColors.globalWhite,
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.appThem),
                                icon: Icon(
                                  Icons.image,
                                  color: AppColors.globalWhite,
                                ),
                                onPressed: galOnPressed,
                                label: Text(
                                  'Gallery',
                                  style: TextStyle(
                                    color: AppColors.globalWhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Icon(
              Icons.camera_alt,
              color: AppColors.appThem,
              size: 30.w,
            ),
          ),
        ),
      ],
    );
  }
}

/////
class CustomImagePickerGallery extends StatelessWidget {
  CustomImagePickerGallery({
    required this.backgroundImage,
    required this.galOnPressed,
  });
  ImageProvider<Object>? backgroundImage;
  void Function()? galOnPressed;

  bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        galOnPressed!();
      },
      child: Stack(
        children: <Widget>[
          CircleAvatar(
              radius: 50.0.r,
              backgroundColor: AppColors.globalWhite,
              backgroundImage: backgroundImage),
          Positioned(
            left: isTablet(context) ? 50.w : 65.w,
            top: 65.h,
            child: InkWell(
              onTap: () {
                galOnPressed!();
              },
              child: Icon(
                Icons.camera_alt,
                color: AppColors.appThem,
                size: 30.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
