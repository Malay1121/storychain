import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool validation({bool snackbar = true}) {
    if (isEmptyString(oldPasswordController.text)) {
      if (snackbar) showSnackbar(message: AppStrings.passwordErrorMessage);
      return false;
    } else if (isEmptyString(newPasswordController.text)) {
      if (snackbar) showSnackbar(message: AppStrings.passwordErrorMessage);
      return false;
    }
    return true;
  }
}
