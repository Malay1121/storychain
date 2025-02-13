import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:storychain/app/helper/all_imports.dart';

class ContributeController extends CommonController {
  TextEditingController sentenceController = TextEditingController();
  TextEditingController chatController = TextEditingController();
  String storyId = "";
  RxMap<dynamic, dynamic> story =
      {"story": {}, "contributors": {}, "sentences": {}, "chat": {}}.obs;

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
    FirebaseFirestore.instance
        .collection("story")
        .doc(storyId)
        .collection("chat")
        .orderBy("created_at")
        .snapshots()
        .listen(
      (event) {
        List chats = [];
        for (QueryDocumentSnapshot doc in event.docs) {
          Map chatData = doc.data() as Map? ?? {};
          chatData.addEntries({"doc": doc}.entries);
          chats.add(chatData);
        }
        Map data = {"chat": chats};
        if (story.containsKey("chat")) {
          story["chat"] = data;
        } else {
          story.addEntries(({"chat": data}).entries);
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

  void sendChat() async {
    if (isEmptyString(chatController.text)) {
      showSnackbar(message: AppStrings.pleaseWriteAMessage);
      return;
    }
    await DatabaseHelper.sendChat(
      message: chatController.text,
      storyId: storyId,
      uid: getKey(userDetails, ["uid"], ""),
    );
  }

  void showChat() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: ColorStyle.othersWhite,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 24.w(Get.context!),
        ),
        height: 600.h(Get.context!),
        child: Column(
          children: [
            SizedBox(
              height: 24.h(Get.context!),
            ),
            AppText(
              text: AppStrings.chat,
              style: Styles.h4Bold(
                color: ColorStyle.greyscale900,
              ),
            ),
            SizedBox(
              height: 24.h(Get.context!),
            ),
            Expanded(
              child: StreamBuilder(
                  initialData: story,
                  stream: story.stream,
                  builder: (context, snapshot) {
                    Map localStory = snapshot.data ?? {};
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          if (getKey(localStory, ["chat", "chat"], []).isEmpty)
                            AppText(
                              text: AppStrings.thereAreNoChatsToDisplay,
                              style: Styles.bodyMediumRegular(
                                  color: ColorStyle.greyscale500),
                            ),
                          for (Map chat
                              in getKey(localStory, ["chat", "chat"], []))
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 12.h(context),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    getKey(chat, ["sender"], "") ==
                                            getKey(userDetails, ["uid"], "")
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                children: [
                                  if (chat["sender"] !=
                                      getKey(userDetails, ["uid"], ""))
                                    CommonImage(
                                      imageUrl: getKey(
                                          getContributor(
                                              getKey(chat, ["sender"], "")),
                                          ["profile_picture"],
                                          ""),
                                      fit: BoxFit.cover,
                                      borderRadius: BorderRadius.circular(100),
                                      height: 30.h(context),
                                      width: 30.h(context),
                                    ),
                                  SizedBox(
                                    width: 10.w(context),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w(context),
                                      vertical: 12.h(context),
                                    ),
                                    constraints: BoxConstraints(
                                      maxWidth: 300.w(context),
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorStyle.greyscale100,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(16),
                                        bottomLeft: Radius.circular(getKey(
                                                    chat, ["sender"], "") ==
                                                getKey(userDetails, ["uid"], "")
                                            ? 16
                                            : 8),
                                        bottomRight: Radius.circular(getKey(
                                                    chat, ["sender"], "") ==
                                                getKey(userDetails, ["uid"], "")
                                            ? 8
                                            : 16),
                                        topLeft: Radius.circular(16),
                                      ),
                                    ),
                                    child: AppText(
                                      text: getKey(chat, ["message"], ""),
                                      style: Styles.bodyLargeRegular(
                                        color: ColorStyle.greyscale900,
                                      ),
                                      maxLines: null,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w(context),
                                  ),
                                  if (chat["sender"] ==
                                      getKey(userDetails, ["uid"], ""))
                                    CommonImage(
                                      imageUrl: getKey(
                                          getContributor(
                                              getKey(chat, ["sender"], "")),
                                          ["profile_picture"],
                                          ""),
                                      fit: BoxFit.cover,
                                      borderRadius: BorderRadius.circular(100),
                                      height: 30.h(context),
                                      width: 30.h(context),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
            ),
            Spacer(),
            SizedBox(
              height: 24.h(Get.context!),
            ),
            CommonTextField(
              hintText: AppStrings.writeSentence,
              controller: chatController,
              suffixIcon: CommonButton(
                onTap: () => sendChat(),
                borderRadius: BorderRadius.circular(
                  10,
                ),
                text: AppStrings.send,
                width: 80.w(Get.context!),
                height: 30.h(Get.context!),
              ),
            ),
            SizedBox(
              height: 24.h(Get.context!),
            ),
          ],
        ),
      ),
    );
  }
}
