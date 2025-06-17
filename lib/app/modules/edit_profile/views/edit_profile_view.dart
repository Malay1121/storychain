import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../helper/all_imports.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
              backgroundColor: ColorStyle.othersWhite,
              body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w(context),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 34.h(context),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Icon(
                                    Icons.arrow_back_outlined,
                                    color: ColorStyle.greyscale900,
                                  ),
                                ),
                                SizedBox(
                                  width: 16.w(context),
                                ),
                                AppText(
                                  text: AppStrings.editProfile,
                                  style: Styles.h4Bold(
                                    color: ColorStyle.greyscale900,
                                  ),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 33.5.h(context),
                            ),
                            GestureDetector(
                              onTap: () => controller.selectProfilePicture(),
                              child: Stack(
                                children: [
                                  CommonImage(
                                    imageUrl: controller.profilePicture != null
                                        ? controller.profilePicture!.path
                                        : controller.networkPicture ??
                                            AppImages.profilePicture,
                                    type: controller.profilePicture != null
                                        ? "file"
                                        : controller.networkPicture != null
                                            ? "network"
                                            : "asset",
                                    fit: BoxFit.cover,
                                    borderRadius: BorderRadius.circular(100),
                                    width: 140.h(context),
                                    height: 140.h(context),
                                  ),
                                  Positioned(
                                    bottom: 2.5.h(context),
                                    right: 2.5.w(context),
                                    child: Container(
                                      width: 35.w(context),
                                      height: 35.w(context),
                                      decoration: BoxDecoration(
                                        color: ColorStyle.primary500,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: ColorStyle.othersWhite,
                                        size: 24.t(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 24.h(context),
                            ),
                            CommonTextField(
                              hintText: AppStrings.fullName,
                              controller: controller.nameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                            ),
                            SizedBox(
                              height: 20.h(context),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonTextField(
                                  hintText: AppStrings.username,
                                  controller: controller.usernameController,
                                  textInputAction: TextInputAction.done,
                                ),
                                if (!isEmptyString(
                                    controller.usernameController.text))
                                  FutureBuilder(
                                      future: DatabaseHelper.usernameAvailable(
                                          username: controller
                                              .usernameController.text),
                                      builder: (context, snapshot) {
                                        return snapshot.data != null
                                            ? !(snapshot.data ||
                                                    (getKey(
                                                            controller
                                                                    .userInfo ??
                                                                {},
                                                            ["username"],
                                                            "") ==
                                                        controller
                                                            .usernameController
                                                            .text))
                                                ? GestureDetector(
                                                    child: AppText(
                                                      text: AppStrings
                                                          .usernameAlreadyExists,
                                                      style: Styles
                                                          .bodyMediumRegular(
                                                        color: snapshot.data
                                                            ? ColorStyle
                                                                .alertsStatusSuccess
                                                            : ColorStyle
                                                                .alertsStatusError,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox()
                                            : SizedBox();
                                      }),
                              ],
                            ),
                            SizedBox(
                              height: 20.h(context),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: AppStrings.gender,
                                  style: Styles.bodyLargeSemibold(
                                    color: ColorStyle.greyscale900,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h(context),
                                ),
                                Wrap(
                                  runSpacing: 10.h(context),
                                  spacing: 10.w(context),
                                  children: [
                                    for (String gender in controller.genders)
                                      CommonButton(
                                        width: 120.w(context),
                                        height: 45.h(context),
                                        text: gender,
                                        enabled: false,
                                        backgroundColor:
                                            controller.isGenderSelected(gender)
                                                ? ColorStyle.primary500
                                                : Colors.transparent,
                                        border: controller
                                                .isGenderSelected(gender)
                                            ? null
                                            : Border.all(
                                                color: ColorStyle.primary500,
                                              ),
                                        textColor:
                                            controller.isGenderSelected(gender)
                                                ? ColorStyle.othersWhite
                                                : ColorStyle.primary500,
                                        onTap: () =>
                                            controller.selectGender(gender),
                                      ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50.h(context),
                                ),
                                CommonButton(
                                  text: AppStrings.changePassword,
                                  border: Border.all(
                                    color: ColorStyle.primary500,
                                  ),
                                  // width: 184.w(context),
                                  backgroundColor: Colors.transparent,
                                  textColor: ColorStyle.primary500,
                                  enabled: false,
                                  onTap: () =>
                                      Get.offAndToNamed(Routes.CHANGE_PASSWORD),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 70.h(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h(context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder(
                            future: controller.page1Validation(snackbar: false),
                            builder: (context, snapshot) {
                              return CommonButton(
                                text: AppStrings.save,
                                // width: 184.w(context),
                                backgroundColor: snapshot.data ?? false
                                    ? ColorStyle.primary500
                                    : ColorStyle.alertsStatusButtonDisabled,
                                enabled: snapshot.data ?? false,
                                onTap: () => controller.editProfile(),
                              );
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 20.h(context),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
