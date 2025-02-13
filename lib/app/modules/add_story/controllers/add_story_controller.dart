import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

class AddStoryController extends CommonController {
  TextEditingController starterSentenceController = TextEditingController();
  TextEditingController maxSentencesController = TextEditingController();
  TextEditingController maxLiveController = TextEditingController();

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

  void addStory() async {
    if (validation()) {
      String id = await DatabaseHelper.addStory(
          starterSentence: starterSentenceController.text,
          maxSentences: int.parse(maxSentencesController.text),
          maxLive: int.parse(maxLiveController.text),
          uid: getKey(userDetails, ["uid"], ""));
      if (isEmptyString(id)) {
        EasyLoading.dismiss();
      } else {
        Get.offAndToNamed(Routes.CONTRIBUTE, arguments: {"story_id": id});
      }
    }
  }

  bool validation({bool snackbar = true}) {
    if (isEmptyString(starterSentenceController.text)) {
      if (snackbar == true)
        showSnackbar(message: AppStrings.starterSentenceValidation);
      return false;
    } else if (isEmptyString(maxSentencesController.text)) {
      if (snackbar == true)
        showSnackbar(message: AppStrings.maxSentencesValidation);
      return false;
    } else if (isEmptyString(maxLiveController.text)) {
      if (snackbar == true) showSnackbar(message: AppStrings.maxLiveValidation);
      return false;
    }
    return true;
  }
}
