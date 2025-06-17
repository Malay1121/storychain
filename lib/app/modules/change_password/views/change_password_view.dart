import 'package:flutter/material.dart';
import 'package:flutter_responsive_helper/flutter_responsive_helper.dart';

import 'package:get/get.dart';

import '../../../helper/all_imports.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      init: ChangePasswordController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorStyle.othersWhite,
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w(context),
              ),
              child: SingleChildScrollView(
                child: Column(
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
                          text: AppStrings.changePassword,
                          style: Styles.h4Bold(
                            color: ColorStyle.greyscale900,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 36.h(context),
                    ),
                    CommonTextField(
                      hintText: AppStrings.oldPassword,
                      controller: controller.oldPasswordController,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: ColorStyle.greyscale500,
                        size: 20.t(context),
                      ),
                    ),
                    SizedBox(
                      height: 20.h(context),
                    ),
                    CommonTextField(
                      hintText: AppStrings.newPassword,
                      controller: controller.newPasswordController,
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
                      text: AppStrings.changePassword,
                      enabled: controller.validation(snackbar: false),
                      onTap: () => null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
