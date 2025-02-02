import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorStyle.othersWhite,
            body: controller.page == 0
                ? SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w(context),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 34.h(context),
                            ),
                            Icon(
                              Icons.arrow_back_outlined,
                              color: ColorStyle.greyscale900,
                            ),
                            SizedBox(
                              height: 70.h(context),
                            ),
                            AppText(
                              text: AppStrings.createYourAccount,
                              style: Styles.h1Bold(
                                color: ColorStyle.greyscale900,
                              ),
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: 60.h(context),
                            ),
                            CommonTextField(
                              hintText: AppStrings.email,
                              controller: controller.emailController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icon(
                                Icons.email,
                                color: ColorStyle.greyscale500,
                                size: 20.t(context),
                              ),
                            ),
                            SizedBox(
                              height: 20.h(context),
                            ),
                            CommonTextField(
                              hintText: AppStrings.password,
                              controller: controller.passwordController,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: ColorStyle.greyscale500,
                                size: 20.t(context),
                              ),
                            ),
                            SizedBox(
                              height: 64.h(context),
                            ),
                            CommonButton(
                              text: AppStrings.next,
                              backgroundColor:
                                  controller.page0Validation(snackbar: false)
                                      ? ColorStyle.primary500
                                      : ColorStyle.alertsStatusButtonDisabled,
                              enabled:
                                  controller.page0Validation(snackbar: false),
                              onTap: () => controller.next(),
                            ),
                            SizedBox(
                              height: 70.h(context),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 96.w(context),
                                  color: ColorStyle.greyscale200,
                                  height: 1,
                                ),
                                AppText(
                                  text: AppStrings.orContinueWith,
                                  centered: true,
                                  style: Styles.bodyXlargeSemibold(
                                    color: ColorStyle.greyscale700,
                                  ),
                                  width: 164.w(context),
                                  height: 25.h(context),
                                ),
                                Container(
                                  width: 96.w(context),
                                  color: ColorStyle.greyscale200,
                                  height: 1,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 150.h(context),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  text: AppStrings.alreadyHaveAnAccount,
                                  style: Styles.bodyMediumRegular(
                                    color: ColorStyle.greyscale500,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w(context),
                                ),
                                AppText(
                                  text: AppStrings.signIn,
                                  style: Styles.bodyMediumRegular(
                                    color: ColorStyle.primary500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  )
                : Column(
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
                                SizedBox(
                                  height: 34.h(context),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_back_outlined,
                                      color: ColorStyle.greyscale900,
                                    ),
                                    SizedBox(
                                      width: 16.w(context),
                                    ),
                                    AppText(
                                      text: AppStrings.completeYourProfile,
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
                                CommonImage(
                                  imageUrl: AppImages.profilePicture,
                                  type: "asset",
                                  fit: BoxFit.cover,
                                  width: 140.h(context),
                                  height: 140.h(context),
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
                                          future:
                                              DatabaseHelper.usernameAvailable(
                                                  username: controller
                                                      .usernameController.text),
                                          builder: (context, snapshot) {
                                            return snapshot.data != null
                                                ? AppText(
                                                    text: snapshot.data
                                                        ? AppStrings
                                                            .usernameAvailable
                                                        : AppStrings
                                                            .usernameAlreadyExists,
                                                    style: Styles
                                                        .bodyMediumRegular(
                                                      color: snapshot.data
                                                          ? ColorStyle
                                                              .alertsStatusSuccess
                                                          : ColorStyle
                                                              .alertsStatusError,
                                                    ),
                                                  )
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
                                        for (String gender
                                            in controller.genders)
                                          CommonButton(
                                            width: 120.w(context),
                                            height: 45.h(context),
                                            text: gender,
                                            enabled: false,
                                            backgroundColor: controller
                                                    .isGenderSelected(gender)
                                                ? ColorStyle.primary500
                                                : Colors.transparent,
                                            border: controller
                                                    .isGenderSelected(gender)
                                                ? null
                                                : Border.all(
                                                    color:
                                                        ColorStyle.primary500,
                                                  ),
                                            textColor: controller
                                                    .isGenderSelected(gender)
                                                ? ColorStyle.othersWhite
                                                : ColorStyle.primary500,
                                            onTap: () =>
                                                controller.selectGender(gender),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 70.h(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonButton(
                            width: 184.w(context),
                            text: AppStrings.previous,
                            enabled: false,
                            backgroundColor: ColorStyle.primary100,
                            textColor: ColorStyle.primary500,
                            onTap: () => controller.previous(),
                          ),
                          SizedBox(
                            width: 12.w(context),
                          ),
                          FutureBuilder(
                              future:
                                  controller.page1Validation(snackbar: false),
                              builder: (context, snapshot) {
                                return CommonButton(
                                  text: AppStrings.signUp,
                                  width: 184.w(context),
                                  backgroundColor: snapshot.data ?? false
                                      ? ColorStyle.primary500
                                      : ColorStyle.alertsStatusButtonDisabled,
                                  enabled: snapshot.data ?? false,
                                  onTap: () => controller.signUp(),
                                );
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 20.h(context),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
