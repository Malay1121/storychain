import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SigninController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
              backgroundColor: ColorStyle.othersWhite,
              body: SingleChildScrollView(
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
                          text: AppStrings.welcomeBack,
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
                          text: AppStrings.signIn,
                          backgroundColor:
                              controller.validation(snackbar: false)
                                  ? ColorStyle.primary500
                                  : ColorStyle.alertsStatusButtonDisabled,
                          enabled: controller.validation(snackbar: false),
                          onTap: () => controller.submit(),
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
                              text: AppStrings.dontHaveAnAccount,
                              style: Styles.bodyMediumRegular(
                                color: ColorStyle.greyscale500,
                              ),
                            ),
                            SizedBox(
                              width: 8.w(context),
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed(Routes.SIGNUP),
                              child: AppText(
                                text: AppStrings.signUp,
                                style: Styles.bodyMediumRegular(
                                  color: ColorStyle.primary500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h(context),
                        ),
                      ],
                    )),
              )),
        );
      },
    );
  }
}
