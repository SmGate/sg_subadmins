// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:societyadminapp/Module/Chat%20Moderator/component/blocked_user_list_item.dart';
import 'package:societyadminapp/Module/Chat%20Moderator/controller/blocked_user_controller.dart';

import 'package:societyadminapp/Module/Chat%20Moderator/model/blocked_residents_model.dart'
    as bu;
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/empty_list.dart';
import 'package:societyadminapp/Widgets/loading.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/Widgets/my_textform_field.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';

class BlockedUser extends StatelessWidget {
  const BlockedUser({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<BlockedUserController>();
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
                  text: 'Blocked User',
                  onTap: () {
                    Get.offNamed(homescreen, arguments: controller.user);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MyTextFormField(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                  width: double.infinity,
                  hintText: "Search Here",
                  labelText: "Search Here",
                  onChanged: (v) {
                    controller.searchVal.value = v;
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
                          padding: const EdgeInsets.only(top: 200),
                          child:
                              Center(child: CircularIndicatorUnderWhiteBox()),
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
                        final bu.Datum blockerUser = item as bu.Datum;

                        return Obx(() {
                          if ((blockerUser.username!
                                      .toLowerCase()
                                      .contains(controller.searchVal.value) &&
                                  controller.searchVal.value.isNotEmpty) ||
                              controller.searchVal.value.isEmpty) {
                            return Padding(
                                padding: EdgeInsets.only(
                                    top: index == 0 ? 20 : 15,
                                    left: 20,
                                    right: 20),
                                child: BlockedUserItemsList(
                                  index: index,
                                  blockerUsers: blockerUser,
                                  controller: controller,
                                ));
                          } else {
                            return Container();
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
