import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

class UserProfileController extends CommonController {
  Map userProfile = {};
  List contributedStories = [];
  List stories = [];

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
    } else {
      Get.back();
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

  void getStories({String? uid}) async {
    await DatabaseHelper.getStories(uid: uid ?? Get.arguments["userId"])
        .then((value) {
      stories.addAll(value?.toList() ?? []);
      update();
    });
  }

  void getContributedStories({String? uid}) async {
    await DatabaseHelper.getContributedStories(
            uid: uid ?? Get.arguments["userId"])
        .then((value) {
      contributedStories.addAll(value?.toList() ?? []);
      update();
    });
  }

  void getUserProfile() async {
    await DatabaseHelper.getUser(userId: Get.arguments["userId"]).then((value) {
      userProfile = value;
      update();
    });
    getContributedStories(
      uid: getKey(userProfile, ["uid"], ""),
    );
  }
}
