// Assuming you have a Datum model with required fields
import 'package:flutter/material.dart';
import 'package:societyadminapp/Module/Chat%20Moderator/controller/blocked_user_controller.dart';
import 'package:societyadminapp/Module/Chat%20Moderator/model/blocked_residents_model.dart';
import 'package:societyadminapp/Widgets/custom_card.dart';
import 'package:societyadminapp/utils/Constants/app_images.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

class BlockedUserItemsList extends StatelessWidget {
  final int index;
  final Datum blockerUsers;
  final BlockedUserController controller;

  BlockedUserItemsList({
    required this.index,
    required this.blockerUsers,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet(BuildContext context) {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return CustomCard(
      margin: EdgeInsets.only(
          top: index == 0 ? 8 : 5, bottom: 10, left: 10, right: 10),
      boxShadow: BoxShadow(),
      onTap: () {},
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.user,
              height: 50,
            ),
            SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 180,
                  child: Text(
                    blockerUsers.username ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                SizedBox(
                    width: 180, child: Text(blockerUsers.houseaddress ?? "")),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Text(
                      "Status",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(blockerUsers.status == 1 ? "blocked" : "not blocked"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: isTablet(context) ? 300 : 70),
                  child: SizedBox(
                      height: isTablet(context) ? 40 : 30,
                      child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.appThem,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              controller.unBlockResident(
                                  residentId:
                                      blockerUsers.residentid.toString());
                            },
                            child: Text(
                              "Un-block",
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.globalWhite,
                              ),
                            ),
                          ))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
