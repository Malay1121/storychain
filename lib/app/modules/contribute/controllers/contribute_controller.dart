import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

class ContributeController extends CommonController {
  TextEditingController sentenceController = TextEditingController();
  String storyId = "";
  RxMap<dynamic, dynamic> story =
      {"story": {}, "contributors": {}, "sentences": {}}.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["story_id"] != null) {
        storyId = Get.arguments["story_id"];
        getStory();
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

  void getStory() async {
    FirebaseFirestore.instance
        .collection("story")
        .doc(storyId)
        .snapshots()
        .listen(
      (event) {
        if (story.containsKey("story")) {
          story["story"] = event.data() ?? {};
        } else {
          story.addEntries((event.data() ?? {}).entries);
        }
        update();
      },
    );
    FirebaseFirestore.instance
        .collection("contributors")
        .where("story_id", isEqualTo: storyId)
        .snapshots()
        .listen(
      (event) async {
        List contributors = [];
        for (QueryDocumentSnapshot doc in event.docs) {
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection("users")
              .doc(doc["user_id"])
              .get();
          Map contributorData = userDoc.data() as Map? ?? {};
          contributorData
              .addEntries({"user_doc": doc, "contributor_doc": doc}.entries);
          contributors.add(contributorData);
        }
        Map data = {"contributors": contributors};
        if (story.containsKey("contributors")) {
          story["contributors"] = data;
        } else {
          story.addEntries(({"contributors": data}).entries);
        }
        update();
      },
    );
    FirebaseFirestore.instance
        .collection("sentences")
        .where("story_id", isEqualTo: storyId)
        .orderBy("created_at")
        .snapshots()
        .listen(
      (event) {
        List sentences = [];
        for (QueryDocumentSnapshot doc in event.docs) {
          Map sentenceData = doc.data() as Map? ?? {};
          sentenceData.addEntries({"doc": doc}.entries);
          sentences.add(sentenceData);
        }
        Map data = {"sentences": sentences};
        if (story.containsKey("sentences")) {
          story["sentences"] = data;
        } else {
          story.addEntries(({"sentences": data}).entries);
        }
        update();
      },
    );
  }

  Map getContributor(String uid) {
    return (getKey(story, [
      "contributors",
      "contributors",
    ], []) as List)
        .firstWhere(
      (element) => element["uid"] == uid,
      orElse: () => {},
    );
  }

  void sendSentence() async {
    if (getKey(story, ["story", "max_sentence"], 0) <=
        getKey(story, ["sentences", "sentences"], []).length) {
      showSnackbar(
        message: AppStrings.sorryButThisStoryIsComplete,
      );
      return;
    }
    if (isEmptyString(sentenceController.text)) {
      showSnackbar(message: AppStrings.pleaseWriteASentence);
      return;
    }
    if (getKey(getKey(story, ["sentences", "sentences"], []).last,
            ["contributor_id"], "") ==
        getKey(userDetails, ["uid"], "")) {
      showSnackbar(
        message: AppStrings.youCannotWriteTwoMessagesBackToBack,
      );
      return;
    }
    await DatabaseHelper.sendSentence(
      sentence: sentenceController.text,
      storyId: storyId,
      uid: getKey(userDetails, ["uid"], ""),
    );
  }
}
