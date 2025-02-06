import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(
      init: UserProfileController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w(context),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: Icon(
                                  Icons.arrow_back_outlined,
                                  color: ColorStyle.greyscale900,
                                  size: 28.t(context),
                                ),
                              ),
                              AppText(
                                text: getKey(controller.userProfile, ["name"],
                                    AppStrings.profile),
                                style: Styles.h4Bold(
                                  color: ColorStyle.greyscale900,
                                ),
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.settings_outlined,
                                  color: Colors.transparent,
                                  size: 28.t(context),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 34.h(context),
                          ),
                          CommonImage(
                            imageUrl: getKey(controller.userProfile,
                                    ["profile_picture"], null) ??
                                AppImages.profilePicture,
                            type: getKey(controller.userProfile,
                                        ["profile_picture"], null) !=
                                    null
                                ? "file"
                                : "asset",
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(100),
                            width: 140.h(context),
                            height: 140.h(context),
                          ),
                          SizedBox(
                            height: 12.h(context),
                          ),
                          AppText(
                            text: "@${getKey(controller.userProfile, [
                                  "username"
                                ], AppStrings.profile)}",
                            style: Styles.h5Bold(
                              color: ColorStyle.greyscale900,
                            ),
                          ),
                          SizedBox(
                            height: 8.h(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                CommonBottomBar(
                  selectedTab: AppStrings.profile,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
