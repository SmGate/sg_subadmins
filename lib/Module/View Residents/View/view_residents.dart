// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:societyadminapp/Module/View%20Residents/Controller/view_residents_controller.dart';
import 'package:societyadminapp/Module/View%20Residents/Model/all_residens_model.dart';
import 'package:societyadminapp/Module/View%20Residents/View/resident_records.dart';
import 'package:societyadminapp/Widgets/app_gradient.dart';
import 'package:societyadminapp/Widgets/empty_list.dart';
import 'package:societyadminapp/Widgets/loading.dart';
import 'package:societyadminapp/Widgets/my_button.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/Extensions/extensions.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import '../../../Routes/set_routes.dart';
import '../components/Detail_shown_dialog_box.dart';
import '../components/resident_n_gatekeeper_view_card.dart';

class ViewResidents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ViewResidentController>();
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(homescreen, arguments: controller.user);

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              MyBackButton(
                text: 'Residents',
                onTap: () {
                  Get.offNamed(homescreen, arguments: controller.user);
                  Get.deleteAll();
                },
              ),
              Expanded(
                child: PagedListView(
                  shrinkWrap: true,
                  primary: false,
                  pagingController: controller.pagingController,
                  addAutomaticKeepAlives: false,
                  builderDelegate: PagedChildBuilderDelegate(
                    firstPageProgressIndicatorBuilder: (context) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 250),
                        child: Center(child: CircularIndicatorUnderWhiteBox()),
                      ));
                    },
                    newPageProgressIndicatorBuilder: (context) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                              color: AppColors.appThem),
                        ),
                      );
                    },
                    noItemsFoundIndicatorBuilder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: EmptyList(
                          name: 'No Entrise',
                        ),
                      );
                    },
                    itemBuilder: (context, item, index) {
                      final Datum residents = item as Datum;

                      return GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: AppColors.globalWhite,
                                  surfaceTintColor: AppColors.globalWhite,
                                  insetAnimationCurve:
                                      Curves.easeInOutCubicEmphasized,
                                  insetAnimationDuration: Duration(seconds: 3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: SizedBox(
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  residents.firstname! +
                                                      " " +
                                                      residents.lastname
                                                          .toString(),
                                                  style: GoogleFonts.montserrat(
                                                    color: HexColor('#4D4D4D'),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize:
                                                        ScreenUtil().setSp(18),
                                                  ),
                                                ),
                                                5.ph,
                                                Text(
                                                  residents.mobileno ?? "",
                                                  style: GoogleFonts.ubuntu(
                                                      color:
                                                          HexColor('#1A1A1A'),
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: ScreenUtil()
                                                          .setSp(16)),
                                                ),
                                              ],
                                            ),
                                            20.ph,
                                            DetailShownDialogBox(
                                              icon: AppImages.contact,
                                              heading: 'Mobile No',
                                              text:
                                                  residents.mobileno.toString(),
                                              isPng: true,
                                            ),
                                            DetailShownDialogBox(
                                                icon: AppImages.address,
                                                isPng: true,
                                                heading: 'Address',
                                                text: residents.address),
                                            DetailShownDialogBox(
                                                icon: AppImages.residentType,
                                                isPng: true,
                                                heading: 'Residental Type',
                                                text: residents.residenttype),
                                            DetailShownDialogBox(
                                                icon: AppImages.propertytype,
                                                heading: 'Property Type',
                                                isPng: true,
                                                text: residents.propertytype),
                                            DetailShownDialogBox(
                                                icon: AppImages.carSvg,
                                                heading: 'Vehicle No',
                                                isPng: false,
                                                text: residents.vechileno),
                                            DetailShownDialogBox(
                                                icon: AppImages.cnic,
                                                isPng: true,
                                                heading: 'CNIC',
                                                text: residents.cnic ?? 'N/A'),
                                            MyButton(
                                              name: "Show Records",
                                              border: 6,
                                              gradient:
                                                  AppGradients.buttonGradient,
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Get.to(ResidentRecordsScreen(
                                                  residentId: residents
                                                      .residentid
                                                      .toString(),
                                                ));
                                              },
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            MyButton(
                                              name: "Cancel",
                                              border: 6,
                                              gradient:
                                                  AppGradients.buttonGradient,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: ResidentsNGateKeeperViewCard(
                          image: Api.imageBaseUrl + residents.image.toString(),
                          name: residents.firstname.toString() +
                              " " +
                              residents.lastname.toString(),
                          mobileno: residents.mobileno.toString(),
                          showButton: false,
                          isShowNexButton: true,
                        ),
                      );
                    },
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
