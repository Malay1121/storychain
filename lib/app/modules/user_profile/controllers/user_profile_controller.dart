import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

class UserProfileController extends CommonController {
  Map userProfile = {};

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["userProfile"] != null) {
        userProfile = Get.arguments["userProfile"];
      } else if (Get.arguments["userId"] != null) {
        getUserProfile();
      } else {
        Get.back();
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getUserProfile() async {
    await DatabaseHelper.getUser(userId: Get.arguments["userId"]).then((value) {
      userProfile = value;
      update();
    });
  }
}
