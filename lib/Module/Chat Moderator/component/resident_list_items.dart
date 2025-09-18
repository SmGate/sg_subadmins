import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Module/Chat%20Moderator/controller/moderation_controller.dart';
import 'package:societyadminapp/Widgets/custom_card.dart';
import 'package:societyadminapp/utils/Constants/api_routes.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/Module/Chat%20Moderator/model/residents_model.dart';

// Assuming you have a Datum model with required fields
class ResidentItemsList extends StatelessWidget {
  final int index;
  final Datum resident;
  final ModerationController controller;

  ResidentItemsList({
    required this.index,
    required this.resident,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet(BuildContext context) {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    bool isModerator = resident.isModerator == 1;

    return Obx(() {
      bool isChecked =
          controller.selectedResidentIds.contains(resident.id ?? 0);

      return CustomCard(
        margin: EdgeInsets.only(
            top: index == 0 ? 20 : 10, bottom: 10, left: 20, right: 20),
        boxShadow: BoxShadow(),
        onTap: () {},
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  Api.imageBaseUrl + resident.image.toString(),
                ),
              ),
              title: Text(
                '${resident.firstname} ${resident.lastname}',
              ),
              subtitle: Text(resident.mobileno.toString()),
              trailing: isModerator
                  ? SizedBox() // If the resident is a moderator, hide the checkbox
                  : Checkbox(
                      checkColor: AppColors.globalWhite,
                      activeColor: AppColors.appThem,
                      value: isChecked,
                      onChanged: (bool? value) {
                        if (value == true) {
                          controller.addResident(resident.id ?? 0);
                        } else {
                          controller.removeResident(resident.id ?? 0);
                        }
                      },
                    ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Status",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(isModerator ? "Moderator" : "Not Moderator"),
                Spacer(),
                isModerator
                    ? SizedBox(
                        height: isTablet(context) ? 40 : 30,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Obx(() => controller.loading2.value
                              ? CircularProgressIndicator(
                                  color: AppColors.appThem,
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.appThem,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (controller.selectedResidentIds.length >
                                        1) {
                                      // Remove the resident and make the selected residents moderators
                                      controller
                                          .removeResident(resident.id ?? 0);
                                      controller.makeModerator(
                                        society_id: controller
                                            .userdata.societyid
                                            .toString(),
                                        residentIds:
                                            controller.selectedResidentIds,
                                        isChangeStatus: true,
                                      );
                                    } else {
                                      // Show a snackbar if there is only one moderator left
                                      Get.snackbar(
                                        "Message",
                                        "At least one moderator must remain.",
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Change",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.globalWhite,
                                    ),
                                  ),
                                )),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      );
    });
  }
}
